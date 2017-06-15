# ROSConnector

ROSConnector allows you to make your connection to ROSBridge for communication with your robot working on Robot Operating System (ROS).

Using ROSConnector makes your app developing much more easier, because it has functionallity for connecting, sending/recieving messages and making service calls.

## Requirements

- iOS 9.0+
- Xcode 8

## Integration

#### CocoaPods (iOS 8+)

You can use [CocoaPods](http://cocoapods.org/) to install `ROSConnector`by adding it to your `Podfile`:

```ruby
platform :ios, '9.0'
use_frameworks!

target 'MyApp' do
   pod 'ROSConnector'
end
```

Note that this requires CocoaPods version 36, and your iOS deployment target to be at least 8.0:

## Usage

#### Initialization

```swift
import ROSConnector
```

```swift
let host = "ws://10.10.10.111:9090"
ROSConnector.sharedInstance.delegate = self
ROSConnector.sharedInstance.connect(socketHost: host)
```

#### ROSConnectorDelegate Methods

```swift
func managerDidConnect(manager: ROSConnector)
func managerDidTimeout(manager: ROSConnector)
func manager(manager: ROSConnector, didFailWithError: NSError)
func manager(manager: ROSConnector, didCloseWithCode: Int, reason: String, wasClean: Bool)
```

#### Publish Messages

```swift
// Publisher initialization 
var publisher: ROSPublisher?
publisher = ROSConnector.sharedInstance.addPublisher(topic: "/someRobot/someTopic", messageType: "std_msgs/Float64")
publisher?.label = "testPublisher"

// Sending message
let mess = FloatMessage()
mess.data = 10.0
self.publisher?.publish(message: mess)
```

#### Subscribe on topic updates

```swift
// Subscriber initialization 
var subscriber = ROSSubscriber?
subscriber = ROSConnector.sharedInstance.addSubscriber(topic: "/someRobot/someTopic", delegate: self, messageClass: FloatMessage.self)

// Extension for delegate
extension ViewController: ROSSubscriberDelegate {
    func messageRecieved(message: ROSMessage) {
        if let floatMessage = message as? FloatMessage {
            print(floatMessage.data)
        }
    }
}
```

#### Current Availible Message Types

##### Standart Messages

- `EmptyMessage` - [std_msgs/Empty Message](http://docs.ros.org/api/std_msgs/html/msg/Empty.html)
- `BoolMessage` - [std_msgs/Bool Message](http://docs.ros.org/api/std_msgs/html/msg/Bool.html)
- `TimenMessage` - [std_msgs/Time Message](http://docs.ros.org/api/std_msgs/html/msg/Time.html)
- `DurationMessage` - [std_msgs/Duration Message](http://docs.ros.org/api/std_msgs/html/msg/Duration.html)
- `StampMessage` - [std_msgs/Stamp Message](http://docs.ros.org/api/std_msgs/html/msg/Stamp.html)
- `HeaderMessage` - [std_msgs/Header Message](http://docs.ros.org/api/std_msgs/html/msg/Header.html)
- `StringMessage` - [std_msgs/String Message](http://docs.ros.org/api/std_msgs/html/msg/String.html)
- `IntMessage` - [std_msgs/Int32 Message](http://docs.ros.org/api/std_msgs/html/msg/Int32.html)
- `FloatMessage` - [std_msgs/Float64 Message](http://docs.ros.org/api/std_msgs/html/msg/Float64.html)

##### Geometry Messages

- `PointMessage` - [geometry_msgs/Point Message](http://docs.ros.org/api/geometry_msgs/html/msg/Point.html)
- `TwistMessage` - [geometry_msgs/Twist Message](http://docs.ros.org/api/geometry_msgs/html/msg/Twist.html)
- `QuaternionMessage` - [geometry_msgs/Quaternion Message](http://docs.ros.org/api/geometry_msgs/html/msg/Quaternion.html)
- `WrenchMessage` - [geometry_msgs/Wrench Message](http://docs.ros.org/api/geometry_msgs/html/msg/Wrench.html)
- `VectorMessage` - [geometry_msgs/Vector3 Message](http://docs.ros.org/api/geometry_msgs/html/msg/Vector3.html)
- `PoseMessage` - [geometry_msgs/Pose Message](http://docs.ros.org/api/geometry_msgs/html/msg/Pose.html)

##### Sensor Messages

- `HumidityMessage` - [sensor_msgs/RelativeHumidity Message](http://docs.ros.org/api/sensor_msgs/html/msg/RelativeHumidity.html)
- `IMUMessage` - [sensor_msgs/Imu Message](http://docs.ros.org/api/sensor_msgs/html/msg/Imu.html)
- `NavSatFixMessage` - [sensor_msgs/NavSatFix Message](http://docs.ros.org/api/sensor_msgs/html/msg/NavSatFix.html)
- `JointState` - [sensor_msgs/JointState Message](http://docs.ros.org/api/sensor_msgs/html/msg/JointState.html)
- `TemperatureMessage` - [sensor_msgs/Temperature Message](http://docs.ros.org/api/sensor_msgs/html/msg/Temperature.html)
- `NavSetStatusMessage` - [sensor_msgs/NavSatStatus Message](http://docs.ros.org/api/sensor_msgs/html/msg/NavSatStatus.html)

##### ROSCpp

- `LoggerMessage` - [ROSCpp](http://wiki.ros.org/roscpp/Overview/Messages)
