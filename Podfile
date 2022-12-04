platform :ios, '16.0'

def shared_pods
    use_frameworks!
    inhibit_all_warnings!
    pod 'SwiftLint', '~> 0.31'
    pod 'Alamofire', '4.8.1'
    pod 'JGProgressHUD'
    pod 'Kingfisher', '~> 5.0'
end

target 'Marvel' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  shared_pods

  target 'MarvelTests' do
    inherit! :search_paths
    # Pods for testing
  end
end
