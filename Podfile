# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

def testing_pods
    pod 'Quick', '~> 0.9.0'
    pod 'Nimble', '~> 3.2.0'
end

target 'moments' do
    pod 'Firebase', '>= 2.5.1'
    pod 'AWSCore'
    pod 'AWSCognito'
    pod 'AWSS3'
end

target 'momentsTests' do
    testing_pods
end

target 'momentsUITests' do
    testing_pods
end
