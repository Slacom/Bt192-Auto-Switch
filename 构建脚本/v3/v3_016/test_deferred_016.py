#!/usr/bin/env python3
"""Narrow D01501 tests: actual smali, explicit deferred Android SDK layout stub.
Not attached-window timing/Looper, real disk, physical gesture or Bluetooth proof.
"""
import unittest,json
from pathlib import Path
import test_list_016 as T
class VM(T.VM):
 def __init__(self,commit='ok',eager=False):super().__init__(commit);self.eager=eager;self.commits=0;self.forbidRects=True
 def sdk(self,op,target,values):
  name=target.split('->')[1].split('(')[0]
  if name in ('getTop','getBottom') and self.forbidRects:raise AssertionError('Stale rectangle consumed: '+target)
  if name=='commit':self.commits+=1
  if name in ('removeView','addView','removeAllViews') and not self.eager:
   self.calls.append((target,values));o=values[0];args=values[1:]
   if name=='removeView':o.p['children'].remove(args[0])
   elif name=='removeAllViews':o.p['children']=[]
   else:o.p['children'].insert(args[1] if len(args)>1 else len(o.p['children']),args[0])
   o.p['layoutRequested']=True;return None
  return super().sdk(op,target,values)
 def layout(self,parent):
  top=parent.p.get('paddingTop',0)
  for row in parent.p['children']:
   height=row.p.get('measuredHeight',row.p['height']);row.p.update(top=top,bottom=top+height,height=height);top+=height
  parent.p['height']=top;parent.p['layoutRequested']=False
 def begin(self,index=0,heights=None,padding=0):
  scroll,rows=self.make();rows.p['paddingTop']=padding
  if heights:
   for row,height in zip(rows.p['children'],heights):row.p['measuredHeight']=height
  self.layout(rows);original=list(rows.p['children']);y=original[index].p['top']+20
  self.run('V3DeviceScroll','dispatchTouchEvent',scroll,self.event(0,y=float(y)))
  self.run('V3DeviceScroll','run',scroll);return scroll,rows,original
 def seq(self,moves=(160.,140.),up=140.,mask=0,**kw):
  scroll,rows,original=self.begin(**kw)
  for k,y in enumerate(moves):
   self.run('V3DeviceScroll','dispatchTouchEvent',scroll,self.event(2,y=float(y)))
   if mask&(1<<k):self.layout(rows)
  self.run('V3DeviceScroll','dispatchTouchEvent',scroll,self.event(1,y=float(up)))
  return dict(index=rows.p['children'].index(original[kw.get('index',0)]),order=self.memory.get('device_order_v1'),commits=self.commits),scroll,rows,original
class Tests(unittest.TestCase):
 def test_original_counterexample_all_traversal_schedules(self):
  outcomes=[VM().seq(mask=mask)[0] for mask in range(4)];self.assertTrue(all(o==outcomes[0] for o in outcomes));self.assertEqual(outcomes[0]['index'],2);self.assertEqual(outcomes[0]['commits'],1)
 def test_up_latest_position_without_intermediate_move(self):
  for mask in (0,1):self.assertEqual(VM().seq(moves=(160.,),up=140.,mask=mask)[0]['index'],2)
 def test_reversal_same_with_and_without_traversal(self):
  for mask in range(4):self.assertEqual(VM().seq(moves=(160.,10.),up=10.,mask=mask)[0]['index'],0)
 def test_repeated_crossings_and_final_up_are_timing_independent(self):
  patterns=[((220.,80.,280.),260.),((100.,160.,220.),200.),((280.,160.,10.),10.)]
  for moves,up in patterns:
   out=[VM().seq(moves=moves,up=up,mask=mask)[0] for mask in range(8)];self.assertTrue(all(x==out[0] for x in out));self.assertEqual(out[0]['commits'],1)
 def test_variable_measured_heights_and_container_padding(self):
  for heights in ((57,57,57,57,57,57),(100,30,80,60,45,90),(48,90,64,100,52,60)):
   out=[VM().seq(moves=(200.,140.),up=140.,mask=mask,heights=heights,padding=8)[0] for mask in range(4)];self.assertTrue(all(x==out[0] for x in out))
 def test_find_row_uses_current_logical_order_with_scroll(self):
  vm=VM();s,r,original=vm.begin();vm.run('V3DeviceScroll','dragMove',s,160.);s.p['scroll']=60
  self.assertIs(vm.run('V3DeviceScroll','findRow',s,80.),original[0]);self.assertIs(vm.run('V3DeviceScroll','findRow',s,20.),original[2])
 def test_cancel_multitouch_and_detach_before_traversal_restore(self):
  for kind in ('cancel','multi','detach'):
   vm=VM();s,r,old=vm.begin();vm.run('V3DeviceScroll','dragMove',s,160.)
   if kind=='detach':vm.run('V3DeviceScroll','onDetachedFromWindow',s)
   else:
    vm.run('V3DeviceScroll','dispatchTouchEvent',s,vm.event(3 if kind=='cancel' else 5,y=140.))
    if kind=='multi':vm.run('V3DeviceScroll','dispatchTouchEvent',s,vm.event(1,y=140.))
   self.assertEqual(r.p['children'],old);self.assertEqual(vm.commits,0);self.assertNotIn('callback',s.p)
 def test_failed_commit_keeps_old_identity_read_then_retry_succeeds(self):
  for mode in ('false','throw'):
   vm=VM(mode);s,r,old=vm.begin();key=','.join(x.p['tag'][6:] for x in old);vm.memory['device_order_v1']=key
   vm.run('V3DeviceScroll','dragMove',s,160.);vm.run('V3DeviceScroll','dispatchTouchEvent',s,vm.event(1,y=140.))
   self.assertEqual(vm.commits,1);self.assertEqual(r.p['children'],old);self.assertEqual(vm.run('V3DeviceOrder','read',vm.ctx),key)
   vm.commit='ok';vm.layout(r);s,r,old=vm.begin();vm.run('V3DeviceScroll','dragMove',s,160.);vm.run('V3DeviceScroll','dispatchTouchEvent',s,vm.event(1,y=140.))
   self.assertEqual(vm.commits,2);self.assertEqual(vm.run('V3DeviceOrder','read',vm.ctx),vm.disk['device_order_v1'])
 def test_disabled_row_only_reordered_and_no_function_api(self):
  vm=VM();s,r,old=vm.begin(index=1);old[1].p['enabled']=False;vm.run('V3DeviceScroll','dragMove',s,160.);vm.run('V3DeviceScroll','dispatchTouchEvent',s,vm.event(1,y=140.));self.assertFalse(old[1].p['enabled']);self.assertEqual(vm.commits,1)
  self.assertFalse(any(any(x in t for x in ('Bluetooth','V3Targets','Worker;','V3Codec','CdmTrigger')) for t,_ in vm.calls))
 def test_frozen015_negative_control_still_exhibits_blocker(self):
  current=T.M['V3DeviceScroll'];old=Path(__file__).resolve().parent.parent/'v3_015/V3DeviceScroll.smali'
  try:
   T.M['V3DeviceScroll']=T.C.methods(old.read_text());a=VM();a.forbidRects=False;b=VM();b.forbidRects=False
   self.assertEqual(a.seq(mask=1)[0]['index'],2);self.assertEqual(b.seq(mask=0)[0]['index'],1)
  finally:T.M['V3DeviceScroll']=current
if __name__=='__main__':unittest.main(verbosity=2)
