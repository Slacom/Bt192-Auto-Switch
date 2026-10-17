# 026独立构建目录

本目录为BT192 Switch当前源码；不需要整份原软件或旧APK。41类404方法，8项资源，保留025资源表未压缩/4字节对齐修复。本轮只替换为用户选择的candidate2波形＋箭头图标，以及对应素材/许可说明；没有改变应用代码、权限或配置格式。

## 构建环境

Python3标准库＋用户手动开启的本机MT MCP。文件路径必须能被MT读取，建议在同一Android文件系统运行；不自动部署/开启服务，不是完整Gradle工程。请从仓库根目录按[项目说明](https://github.com/Slacom/Bt192-Auto-Switch#构建)运行prepare、compile、unsigned，最后才signed；每次使用新的绝对输出路径。

signed校验原发布证书，私钥不公开。第三方可构建unsigned，不代表能签出同证书更新包；不能靠卸载清数据绕过签名冲突。运行APP本身无需MT、Shizuku或LSPosed框架。

## 源与工具

- [构建驱动](https://github.com/Slacom/Bt192-Auto-Switch/blob/main/构建脚本/v3/v3_026/build.py)：输入哈希固定、逐目标回执、拒绝覆盖、签名检查。
- [最小资源生成器](https://github.com/Slacom/Bt192-Auto-Switch/blob/main/构建脚本/v3/v3_026/build_resources.py)：本项目资源表/空DEX种子，不加载旧APK。
- [安装相关包装门禁](https://github.com/Slacom/Bt192-Auto-Switch/blob/main/构建脚本/v3/v3_026/build_support/apk_packaging.py)：seed、unsigned、signed都必须检查，压缩表/未对齐/重复entry拒绝。
- [源码选择哈希](https://github.com/Slacom/Bt192-Auto-Switch/blob/main/构建脚本/v3/v3_026/selection_identity.json)：固定41类源。旧版本SHA只是来源标识，不是构建下载依赖。
- [自包含主机测试](https://github.com/Slacom/Bt192-Auto-Switch/blob/main/构建脚本/v3/v3_026/tests/test_packaging.py)：无需MT/设备/旧包，不模拟全部安装器。

bootstrap_manifest是本项目最小原生Manifest的编译模板，每次由可读Manifest源码替换，不是整个原应用底包。29个项目类仍保留必要Context/兼容引用；旧关联名前缀参与解析，不盲目替换。9个HiddenApiBypass/helper和3个PathParser为实际依赖，不把去底包等同零第三方。

## 图标与许可

用户提供并明确选择candidate2（带箭头、无LHDC文字/标识）。仅裁透明外边缘，保留主体像素；上游候选包已声明此前为展平栅格修复，不冒称全新矢量源。准备后的PNG用于打包，原PNG留作来源记录；旧带标识素材不在此目录。

第三方实现保留Apache2正文与来源声明，精确上游二进制版本/额外NOTICE仍有认证边界；项目自有代码及素材没有自动套用MIT等许可证。源码同步不等于正式Release，也不承诺全ROM/所有耳机或全部安装场景通过。详见根README和公开验证边界说明。
