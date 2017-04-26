# Apitest
Short description and motivation.

## Version 
0.1.8

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



## TODO
- [x] 可自定义api目录
- [x] 可自定义theme
- [x] 可配置分类
- [ ] 可设定所有API都有的必填项，比如token、客户端类型、客户端版本号
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