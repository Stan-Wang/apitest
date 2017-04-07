# Apitest
Short description and motivation.

## Version 
0.1.4

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

mount apitest到指定url，比如：

```ruby
mount Apitest::Engine => "/apitest"

```

浏览器中访问apitest 的url




## TODO
- [ ] 可自定义api目录
- [ ] 可自定义theme

## Contributing


## License
[MIT License](http://opensource.org/licenses/MIT).