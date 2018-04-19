# AwsomeReactNative

这个库将React Native封装到了一个Pod库中,便于项目以模块化方式快速引入React Native。

React Native `package.json`如下：
```
{
"name": "AspirinFeedback",
"version": "0.0.1",
"private": true,
"scripts": {
"start": "node node_modules/react-native/local-cli/cli.js start"
},
"dependencies": {
"react": "16.3.1",
"react-native": "0.51"
}
}
```

如需要添加依赖或修改RN版本可在此库基础上扩展。
