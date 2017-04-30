# Apitest
- 通过在API controller里的常量，配置API文档
- 并附带一个测试界面，辅助API开发。
- 适用与API开发人员，客户端/前端开发人员交流验证文档。
- 目前无出参，需要提交后，得到无法完全替代API文档

## Version 
0.1.9

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

在routes.rb 配置apitest 目录，比如：

```ruby
Rails.application.routes.draw do

  apitest_for '/apitest'

end
```

浏览器中访问apitest 的url

默认api目录为controllers/api，目录可指定

```ruby
Rails.application.routes.draw do

  apitest_for '/apitest' do 
    Apitest::api_dir 'api'
  end 

end
```

默认使用blue-theme，可指定theme ，theme使用 AdminLTE，直接指定AdminLTE的theme即可：

``` ruby
Rails.application.routes.draw do

  apitest_for '/apitest' do 
    Apitest::theme  'purple-light'
  end

end
```
theme列表如下
```
black
black-light
blue
blue-light
green
green-light
purple
purple-light
red
red-light
yellow
yellow-light
```

API层级为4级
Version -> 分类 -> API组 -> API
其中Version 由第一级目录决定
分类在API中定义，定义方法如下

```ruby
class Api::V1::BindingTrayController < Api::V1::ApplicationController
  APIDOC = {
    type:      '业务API' ,
    group_name: '绑定托盘' ,
    sort:       2 ,
    apis: {
      scan_sn: {  #第一条API
        api_name: '扫描sn' ,
        path: '/api/v1/binding_tray/scan_sn' ,
        method: 'get' ,
        params:{
          barcode: {
            text: 'sn条码' ,
            required: true 
          } , 
          detail_id: {
            text: '托盘列表id' ,
          }
        }
      } ,
      ... #第二条API
    }
  }
  def scan_sn
    ... #your code
  end
```

默认分类为
```ruby
Apitest::default_types  [ '业务API' , '工具API' , '辅助API' ]
```
默认分类可配置，例如：

```ruby
Rails.application.routes.draw do

  apitest_for '/apitest' do 
    Apitest::default_types  [ '银行业务API' , '企业业务API'  ]
  end

end
```

如果所有API有公共必填项，例如token,version，可如下配置

```ruby
Rails.application.routes.draw do

  apitest_for '/apitest' do 
    Apitest::public_required  [ 'token' , 'version'  ]
  end

end
```

可以在指定APITEST中关闭公共必填项，比如登录API，可在具体方法的APIDOC中使用false设定

```ruby
token:false
```

完整配置方法如下
```ruby
class Api::V1::LoginController < ApplicationController

  APIDOC = {
    type:       '业务API' , 
    group_name: '用户登录' ,
    sort:      1 ,
    apis: {
      create: {
        api_name:   '登录' ,
        path:       '/api/v1/login' ,
        method:     'post' ,
        token:      false ,      # 这里可关闭该API的token选项
        params: {
          mobile: {
            required: true ,
          } ,
          password: {
            required: true
          }
        }
      } 
    }
  }
  def create
    ...
  end
```








## TODO
- [x] 可自定义api目录
- [x] 可自定义theme
- [x] 可配置分类
- [x] 可设定公共必填项，比如token、客户端类型、客户端版本号
- [x] 公共必填项可在指定API中关闭
- [ ] ERROR类工具
- [ ] Apitest Example 网站
- [ ] 使用前端route
- [ ] 生成前端mock数据
- [ ] 保存API分类收起展开状态
- [ ] ERROR log 可选输出
- [ ] 一个token默认机制
- [ ] 客户端版本号默认升级实例
- [ ] 操作录屏gif
- [ ] 权限控制
- [ ] 测试数据准备，测试用例
- [ ] 测试中心

## Contributing


## License
[MIT License](http://opensource.org/licenses/MIT).