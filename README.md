# Apitest
Short description and motivation.

## Version 
0.1.3

## Installation
添加如下代码到 Gemfile:

```ruby
gem 'apitest'
```

执行:
```bash
$ bundle install
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
- [ ] 不同平台kill不掉websocket进程的问题
- [ ] 可自定义api目录

## Contributing


## License
[MIT License](http://opensource.org/licenses/MIT).