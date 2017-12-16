Pod::Spec.new do |spec|
  spec.name         = 'BitArray'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/dduan/BitArray'
  spec.authors      = { 'Daniel Duan' => 'daniel@duan.ca' }
  spec.summary      = 'A space-efficient bit array with `RandomAccessCollection` conformance in Swift.'
  spec.source       = { :git => 'https://github.com/dduan/BitArray.git', :tag => spec.version }
  spec.source_files = 'Sources/**/*.swift'
end
