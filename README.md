# Apitest
Short description and motivation.

## Version 
0.1.5

## Installation
添加如下代码到 Gemfile:

```ruby
gem 'apitest'
```

执行:
```bash
$ bundle install
```

安装lsof


```bash
$ yum install lsof -y  #CentOS
```

```bash
$ sudo apt-get install lsof -y #Ubuntu
```

```bash
$ brew install lsof #MacOS
```

## Usage

约定的api目录如下：
```shell
├── controllers
│   ├── api
│   │   └── v1
│   │       ├── foo_controller.rb
│   │       ├── bar_controller.rb
│   │   └── v2
│   │       ├── foobar_controller.rb
│   │       ├── barfoo_controller.rb
```

在routes.rb 配置apitest 目录，比如：

```ruby
  apitest_for '/apitest'

```

浏览器中访问apitest 的url

默认api目录为controllers/api，目录可指定

```ruby
  apitest_for '/apitest' do 
    Apitest::api_dir 'api'
  end 
```

默认使用blue-theme，可指定theme ，theme使用 AdminLTE，直接指定AdminLTE的theme即可：

``` ruby
  apitest_for '/apitest' do 
    Apitest::theme  'purple-light'
  end
```
theme列表如下
```
black-light
black
blue-light
blue
green-light
green
purple-light
purple
red-light
red
yellow-light
yellow
```



## TODO
- [x] 可自定义api目录
- [x] 可自定义theme
- [ ] ERROR类工具
- [ ] APIDOC美化
- [ ] 权限控制
- [ ] 测试数据准备，测试用例
- [ ] 测试中心

## Contributing


## License
[MIT License](http://opensource.org/licenses/MIT).