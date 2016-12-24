
Pod::Spec.new do |s|

  s.name         = "ETExtension" # 库名称
  s.version      = "1.0.0" # 库版本
  s.summary      = "自动解析XML节点的值并转换成对象。" # 简介

  s.description  = <<-DESC
                  仿MJExtension写的，自动解析XML数据。还有很多功能没有实现，只是为了方便自己。
                   DESC

  s.homepage     = "https://github.com/LarkNan/ETExtension" # 该库的主页地址
  s.license      = { :type => "MIT", :file => "LICENSE" } # 协议
  s.author             = { "申铭" => "569818710@qq.com" } # 作者
  s.platform     = :ios, "8.0" # 最低适配的版本
  s.source       = { :git => "https://github.com/LarkNan/ETExtension.git", :tag => "#{s.version}" } # 源代码的具体地址以及版本

  s.source_files  = "ETExtensionExample/ETExtension/*.{h,m}" # 提供给别人的文件
  s.requires_arc = true # 是否是ARC

  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2"}
  s.dependency "KissXML", "5.1.2" # 库所依赖的第三方

end
