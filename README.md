# Getting started


# Introduction

<table><tbody><tr><td class = 'into_api' style='border:none;padding:0 0 0 0'><p>Send and receive SMS and MMS messages globally using Telstra's enterprise grade Messaging API. It also allows your application to track the delivery status of both sent and received messages. Get your dedicated Australian number, and start sending and receiving messages today.</p></td><td class = 'into_api_logo' style='width: 20%;border:none'><img class = 'api_logo' style='margin: -26px 0 0 0' src = 'https://test-telstra-retail-tdev.devportal.apigee.io/sites/default/files/messagingapi-icon.png'></td></tr></tbody></table>

# Features

The Telstra Messaging API provides the features below.
| Feature | Description |
| --- | --- |
| `Dedicated Number` | Provision a mobile number for your account to be used as `from` address in the API |
| `Send Messages` | Sending SMS or MMS messages |
| `Receive Messages` | Telstra will deliver messages sent to a dedicated number or to the `notifyURL` defined by you |
| `Broadcast Messages` | Invoke a single API call to send a message to a list of numbers provided in `to` |
| `Delivery Status` | Query the delivery status of your messages |
| `Callbacks` | Provide a notification URL and Telstra will notify your app when a message status changes |
| `Alphanumeric Identifier` | Differentiate yourself by providing an alphanumeric string in `from`. This feature is only available on paid plans |
| `Concatenation` | Send messages up to 1900 characters long and Telstra will automaticaly segment and reassemble them |
| `Reply Request` | Create a chat session by associating `messageId` and `to` number to track responses received from a mobile number. We will store this association for 8 days |
| `Character set` | Accepts all Unicode characters as part of UTF-8 |
| `Bounce-back response` | See if your SMS hits an unreachable or unallocated number (Australia Only) |
| `Queuing` | Messaging API will automatically queue and deliver each message at a compliant rate. |
| `Emoji Encoding` | The API supports the encoding of the full range of emojis. Emojis in the reply messages will be in their UTF-8 format. |

## Delivery Notification or Callbacks

The API provides several methods for notifying when a message has been delivered to the destination.

1. When you send a message there is an opportunity to specify a `notifyURL`. Once the message has been delivered the API will make a call to this URL to advise of the message status.
2. If you do not specify a URL you can always call the `GET /status` API to get the status of the message.

# Getting Access to the API

1. Register at [https://dev.telstra.com](https://dev.telstra.com).
2. After registration, login to [https://dev.telstra.com](https://dev.telstra.com) and navigate to the **My apps** page.
3. Create your application by clicking the **Add new app** button
4. Select **API Free Trial** Product when configuring your application. This Product includes the Telstra Messaging API as well as other free trial APIs. Your application will be approved automatically.
5. There is a maximum of 1000 free messages per developer. Additional messages and features can be purchased from [https://dev.telstra.com](https://dev.telstra.com).
6. Note your `Client key` and `Client secret` as these will be needed to provision a number for your application and for authentication.

Now head over to **Getting Started** where you can find a postman collection as well as some links to sample apps and SDKs to get you started.

Happy Messaging!

# Frequently Asked Questions

**Q: Is creating a subscription via the Provisioning call a required step?**

A. Yes. You will only be able to start sending messages if you have a provisioned dedicated number. Use Provisioning to create a dedicated number subscription, or renew your dedicated number if it has expired.

**Q: When trying to send an SMS I receive a `400 Bad Request` response. How can I fix this?**

A. You need to make sure you have a provisioned dedicated number before you can send an SMS. 
If you do not have a provisioned dedicated number and you try to send a message via the API, you will get the error below in the response:

<pre><code class="language-sh">{
  "status":"400",
  "code":"DELIVERY-IMPOSSIBLE",
  "message":"Invalid \'from\' address specified"
}</code></pre>

Use Provisioning to create a dedicated number subscription, or renew your dedicated number if it has expired.

**Q: How long does my dedicated number stay active for?**

A. When you provision a dedicated number, by default it will be active for 30 days. 
You can use the `activeDays` parameter during the provisioning call to increment or decrement the number of days your dedicated number will remain active.

Note that Free Trial apps will have 30 days as the maximum `activeDays` they can add to their provisioned number. If the Provisioning call is made several times within that 30-Day period, it will return the `expiryDate` in the Unix format and will not add any activeDays until after that `expiryDate`.

**Q: Can I send a broadcast message using the Telstra Messaging API?**

A. Yes. Recipient numbers can be in the form of an array of strings if a broadcast message needs to be sent, allowing you to send to multiple mobile numbers in one API call.
  A sample request body for this will be: `{"to":["+61412345678","+61487654321"],"body":"Test Message"}`
  
**Q: Can I send SMS and MMS to all countries?**

A. You can send SMS and MMS to all countries EXCEPT to countries which are subject to global sanctions namely: Burma, Côte d'Ivoire, Cuba, Iran, North Korea, Syria.

**Q: Can I use `Alphanumeric Identifier` from my paid plan via credit card?**

A. `Alphanumeric Identifier` is only available on Telstra Account paid plans, not through credit card paid plans.

**Q: What is the maximum sized MMS that I can send?**

A. This will depend on the carrier that will receive the MMS. For Telstra it's up to 2MB,  Optus up to 1.5MB and Vodafone only allows up to 500kB. You will need to check with international carriers for thier MMS size limits.

**Q: How is the size of an MMS calculated?**

A. Images are scaled up to approximately 4/3 when base64 encoded.
Additionally, there is approximately 200 bytes of overhead on each MMS.
Assuming the maximum MMS that can be sent on Telstra’s network is 2MB, then the maximum image size that can be sent will be approximately 1.378MB (1.378 x 1.34 + 200, without SOAP encapsulation).

**Q: How is an MMS classified as Small or Large?**

A. MMSes with size below 600kB are classed as Small whereas those that are bigger than 600kB are classed as Large. They will be charged accordingly.

**Q: Are SMILs supported by the Messaging API?**

A. While there will be no error if you send an MMS with a SMIL presentation, the actual layout or sequence defined in the SMIL may not display as expected because most of the new smartphone devices ignore the SMIL presentation layer. SMIL was used in feature phones which had limited capability and SMIL allowed a *powerpoint type* presentation to be provided. Smartphones now have the capability to display video which is the better option for presentations. It is recommended that MMS messages should just drop the SMIL.

**Q: How do I assign a delivery notification or callback URL?**

A. You can assign a delivery notification or callback URL by adding the `notifyURL` parameter in the body of the request when you send a message. Once the message has been delivered, a notification will then be posted to this callback URL.

**Q: What is the difference between the `notifyURL` parameter in the Provisoning call versus the `notifyURL` parameter in the Send Message call?**

A. The `notifyURL` in the Provisoning call will be the URL where replies to the provisioned number will be posted.
On the other hand, the `notifyURL` in the Send Message call will be the URL where the delivery notification will be posted, e.g. when an SMS has already been delivered to the recipient.

# Getting Started

Below are the steps to get started with the Telstra Messaging API.
  1. Generate an OAuth2 token using your `Client key` and `Client secret`.
  2. Use the Provisioning call to create a subscription and receive a dedicated number.
  3. Send a message to a specific mobile number.

## Run in Postman
<a
href="https://app.getpostman.com/run-collection/ded00578f69a9deba256#?env%5BMessaging%20API%20Environments%5D=W3siZW5hYmxlZCI6dHJ1ZSwia2V5IjoiY2xpZW50X2lkIiwidmFsdWUiOiIiLCJ0eXBlIjoidGV4dCJ9LHsiZW5hYmxlZCI6dHJ1ZSwia2V5IjoiY2xpZW50X3NlY3JldCIsInZhbHVlIjoiIiwidHlwZSI6InRleHQifSx7ImVuYWJsZWQiOnRydWUsImtleSI6ImFjY2Vzc190b2tlbiIsInZhbHVlIjoiIiwidHlwZSI6InRleHQifSx7ImVuYWJsZWQiOnRydWUsImtleSI6Imhvc3QiLCJ2YWx1ZSI6InRhcGkudGVsc3RyYS5jb20iLCJ0eXBlIjoidGV4dCJ9LHsiZW5hYmxlZCI6dHJ1ZSwia2V5IjoiQXV0aG9yaXphdGlvbiIsInZhbHVlIjoiIiwidHlwZSI6InRleHQifSx7ImVuYWJsZWQiOnRydWUsImtleSI6Im9hdXRoX2hvc3QiLCJ2YWx1ZSI6InNhcGkudGVsc3RyYS5jb20iLCJ0eXBlIjoidGV4dCJ9LHsiZW5hYmxlZCI6dHJ1ZSwia2V5IjoibWVzc2FnZV9pZCIsInZhbHVlIjoiIiwidHlwZSI6InRleHQifV0="><img
src="https://run.pstmn.io/button.svg" alt="Run in Postman"/></a>

## Sample Apps
  - [Perl Sample App](https://github.com/telstra/MessagingAPI-perl-sample-app)
  - [Happy Chat App](https://github.com/telstra/messaging-sample-code-happy-chat)
  - [PHP Sample App](https://github.com/developersteve/telstra-messaging-php)

## SDK Repos
  - [Messaging API - PHP SDK](https://github.com/telstra/MessagingAPI-SDK-php)
  - [Messaging API - Python SDK](https://github.com/telstra/MessagingAPI-SDK-python)
  - [Messaging API - Ruby SDK](https://github.com/telstra/MessagingAPI-SDK-ruby)
  - [Messaging API - NodeJS SDK](https://github.com/telstra/MessagingAPI-SDK-node)
  - [Messaging API - .Net2 SDK](https://github.com/telstra/MessagingAPI-SDK-dotnet)
  - [Messaging API - Java SDK](https://github.com/telstra/MessagingAPI-SDK-Java)

## Blog Posts
For more information on the Messaging API, you can read these blog posts:
- [Callbacks Part 1](https://dev.telstra.com/content/understanding-messaging-api-callbacks-part-1) 
- [Callbacks Part 2](https://dev.telstra.com/content/understanding-messaging-api-callbacks-part-2)


## How to Build

This client library is a Ruby gem which can be compiled and used in your Ruby and Ruby on Rails project. This library requires a few gems from the RubyGems repository.

1. Open the command line interface or the terminal and navigate to the folder containing the source code.
2. Run ``` gem build telstra_messaging_api.gemspec ``` to build the gem.
3. Once built, the gem can be installed on the current work environment using ``` gem install telstra_messaging_api-2.2.9.gem ```

![Building Gem](https://apidocs.io/illustration/ruby?step=buildSDK&workspaceFolder=Telstra%20Messaging%20API-Ruby&workspaceName=Telstra%20Messaging%20API-Ruby&projectName=telstra_messaging_api&gemName=telstra_messaging_api&gemVer=2.2.9)

## How to Use

The following section explains how to use the TelstraMessagingApi Ruby Gem in a new Rails project using RubyMine&trade;. The basic workflow presented here is also applicable if you prefer using a different editor or IDE.

### 1. Starting a new project

Close any existing projects in RubyMine&trade; by selecting ``` File -> Close Project ```. Next, click on ``` Create New Project ``` to create a new project from scratch.

![Create a new project in RubyMine](https://apidocs.io/illustration/ruby?step=createNewProject0&workspaceFolder=Telstra%20Messaging%20API-Ruby&workspaceName=TelstraMessagingApi&projectName=telstra_messaging_api&gemName=telstra_messaging_api&gemVer=2.2.9)

Next, provide ``` TestApp ``` as the project name, choose ``` Rails Application ``` as the project type, and click ``` OK ```.

![Create a new Rails Application in RubyMine - step 1](https://apidocs.io/illustration/ruby?step=createNewProject1&workspaceFolder=Telstra%20Messaging%20API-Ruby&workspaceName=TelstraMessagingApi&projectName=telstra_messaging_api&gemName=telstra_messaging_api&gemVer=2.2.9)

In the next dialog make sure that correct *Ruby SDK* is being used (minimum 2.0.0) and click ``` OK ```.

![Create a new Rails Application in RubyMine - step 2](https://apidocs.io/illustration/ruby?step=createNewProject2&workspaceFolder=Telstra%20Messaging%20API-Ruby&workspaceName=TelstraMessagingApi&projectName=telstra_messaging_api&gemName=telstra_messaging_api&gemVer=2.2.9)

This will create a new Rails Application project with an existing set of files and folder.

### 2. Add reference of the gem

In order to use the TelstraMessagingApi gem in the new project we must add a gem reference. Locate the ```Gemfile``` in the *Project Explorer* window under the ``` TestApp ``` project node. The file contains references to all gems being used in the project. Here, add the reference to the library gem by adding the following line: ``` gem 'telstra_messaging_api', '~> 2.2.9' ```

![Add references of the Gemfile](https://apidocs.io/illustration/ruby?step=addReference&workspaceFolder=Telstra%20Messaging%20API-Ruby&workspaceName=TelstraMessagingApi&projectName=telstra_messaging_api&gemName=telstra_messaging_api&gemVer=2.2.9)

### 3. Adding a new Rails Controller

Once the ``` TestApp ``` project is created, a folder named ``` controllers ``` will be visible in the *Project Explorer* under the following path: ``` TestApp > app > controllers ```. Right click on this folder and select ``` New -> Run Rails Generator... ```.

![Run Rails Generator on Controllers Folder](https://apidocs.io/illustration/ruby?step=addCode0&workspaceFolder=Telstra%20Messaging%20API-Ruby&workspaceName=TelstraMessagingApi&projectName=telstra_messaging_api&gemName=telstra_messaging_api&gemVer=2.2.9)

Selecting the said option will popup a small window where the generator names are displayed. Here, select the ``` controller ``` template.

![Create a new Controller](https://apidocs.io/illustration/ruby?step=addCode1&workspaceFolder=Telstra%20Messaging%20API-Ruby&workspaceName=TelstraMessagingApi&projectName=telstra_messaging_api&gemName=telstra_messaging_api&gemVer=2.2.9)

Next, a popup window will ask you for a Controller name and included Actions. For controller name provide ``` Hello ``` and include an action named ``` Index ``` and click ``` OK ```.

![Add a new Controller](https://apidocs.io/illustration/ruby?step=addCode2&workspaceFolder=Telstra%20Messaging%20API-Ruby&workspaceName=TelstraMessagingApi&projectName=telstra_messaging_api&gemName=telstra_messaging_api&gemVer=2.2.9)

A new controller class anmed ``` HelloController ``` will be created in a file named ``` hello_controller.rb ``` containing a method named ``` Index ```. In this method, add code for initialization and a sample for its usage.

![Initialize the library](https://apidocs.io/illustration/ruby?step=addCode3&workspaceFolder=Telstra%20Messaging%20API-Ruby&workspaceName=TelstraMessagingApi&projectName=telstra_messaging_api&gemName=telstra_messaging_api&gemVer=2.2.9)

## How to Test

You can test the generated SDK and the server with automatically generated test
cases as follows:

  1. From terminal/cmd navigate to the root directory of the SDK.
  2. Invoke: `bundle exec rake`

## Initialization

### Authentication
In order to setup authentication and initialization of the API client, you need the following information.

| Parameter | Description |
|-----------|-------------|
| o_auth_client_id | OAuth 2 Client ID |
| o_auth_client_secret | OAuth 2 Client Secret |



API client can be initialized as following.

```ruby
# Configuration parameters and credentials
o_auth_client_id = 'o_auth_client_id' # OAuth 2 Client ID
o_auth_client_secret = 'o_auth_client_secret' # OAuth 2 Client Secret

client = TelstraMessagingApi::TelstraMessagingApiClient.new(
  o_auth_client_id: o_auth_client_id,
  o_auth_client_secret: o_auth_client_secret
)
```

The added initlization code can be debugged by putting a breakpoint in the ``` Index ``` method and running the project in debug mode by selecting ``` Run -> Debug 'Development: TestApp' ```.

![Debug the TestApp](https://apidocs.io/illustration/ruby?step=addCode4&workspaceFolder=Telstra%20Messaging%20API-Ruby&workspaceName=TelstraMessagingApi&projectName=telstra_messaging_api&gemName=telstra_messaging_api&gemVer=2.2.9&initLine=client%2520%253D%2520TelstraMessagingApiClient.new%2528%2527o_auth_client_id%2527%252C%2520%2527o_auth_client_secret%2527%2529)


You must now authorize the client.

### Authorizing your client

This SDK uses *OAuth 2.0 authorization* to authorize the client.

The `authorize()` method will exchange the OAuth client credentials for an *access token*.
The access token is an object containing information for authorizing client requests.

 You must pass the *[scopes](#scopes)* for which you need permission to access.
```ruby
begin
  client.auth.authorize(scope: [TelstraMessagingApi::OAuthScopeEnum::NSMS])
rescue TelstraMessagingApi::OAuthProviderException => ex
  # handle exception
end
```

The client can now make authorized endpoint calls.


### Scopes

Scopes enable your application to only request access to the resources it needs while enabling users to control the amount of access they grant to your application. Available scopes are defined in the `OAuthScopeEnum` enumeration.

| Scope Name | Description |
| --- | --- |
| `NSMS` | NSMS |

### Storing an access token for reuse

It is recommended that you store the access token for reuse.

You can store the access token in a file or a database.

```ruby
# store token
save_token_to_database(client.config.o_auth_token)
```

### Creating a client from a stored token

To authorize a client from a stored access token, just set the access token after creating the client:

```ruby
client = TelstraMessagingApi::TelstraMessagingApiClient.new
client.config.o_auth_token = load_token_from_database
```

### Complete example

```ruby
require 'telstra_messaging_api'

include TelstraMessagingApi

# function for storing token to database
def save_token_to_database(token)
  # code to save the token to database
end

# function for loading token from database
def load_token_from_database
  # load token from database and return it (return None if no token exists)
end

# Configuration parameters and credentials
o_auth_client_id = 'o_auth_client_id' # OAuth 2 Client ID
o_auth_client_secret = 'o_auth_client_secret' # OAuth 2 Client Secret

#  create a new client
client = TelstraMessagingApiClient.new(
  o_auth_client_id: o_auth_client_id,
  o_auth_client_secret: o_auth_client_secret
)

# obtain access token, needed for client to be authorized
previous_token = load_token_from_database
if previous_token
  # restore previous access token
  client.config.o_auth_token = previous_token
else
  # obtain new access token
  begin
    token = client.auth.authorize(scope: [OAuthScopeEnum::NSMS])
    save_token_to_database(token)
  rescue OAuthProviderException => ex
    # handle exception
  end
end

# the client is now authorized and you can use controllers to make endpoint calls
```


# Class Reference

## <a name="list_of_controllers"></a>List of Controllers

* [AuthenticationController](#authentication_controller)
* [ProvisioningController](#provisioning_controller)
* [MessagingController](#messaging_controller)

## <a name="authentication_controller"></a>![Class: ](https://apidocs.io/img/class.png ".AuthenticationController") AuthenticationController

### Get singleton instance

The singleton instance of the ``` AuthenticationController ``` class can be accessed from the API Client.

```ruby
authentication_controller = client.authentication
```

### <a name="create_auth_token"></a>![Method: ](https://apidocs.io/img/method.png ".AuthenticationController.create_auth_token") create_auth_token

> To generate an OAuth2 Authentication token, pass through your `Client key` and `Client secret` that you received when you registered for the **API Free Trial** Product.
> The grant_type should be left as `client_credentials` and the scope as `NSMS`.
> The token will expire in one hour.
> 


```ruby
def create_auth_token(client_id,
                          client_secret,
                          grant_type); end
```

#### Parameters

| Parameter | Tags | Description |
|-----------|------|-------------|
| client_id |  ``` Required ```  | TODO: Add a parameter description |
| client_secret |  ``` Required ```  | TODO: Add a parameter description |
| grant_type |  ``` Required ```  ``` DefaultValue ```  | TODO: Add a parameter description |


#### Example Usage

```ruby
client_id = 'client_id'
client_secret = 'client_secret'
grant_type = 'client_credentials'

result = authentication_controller.create_auth_token(client_id, client_secret, grant_type)

```

#### Errors

| Error Code | Error Description |
|------------|-------------------|
| 400 | unsupported_grant_type |
| 401 | invalid_client |
| 404 | The requested URI does not exist |
| 503 | The service requested is currently unavailable |
| 0 | An internal error occurred when processing the request |



[Back to List of Controllers](#list_of_controllers)

## <a name="provisioning_controller"></a>![Class: ](https://apidocs.io/img/class.png ".ProvisioningController") ProvisioningController

### Get singleton instance

The singleton instance of the ``` ProvisioningController ``` class can be accessed from the API Client.

```ruby
provisioning_controller = client.provisioning
```

### <a name="create_subscription"></a>![Method: ](https://apidocs.io/img/method.png ".ProvisioningController.create_subscription") create_subscription

> Invoke the provisioning API to get a dedicated mobile number for an account or application.
> Note that Free Trial apps will have a 30-Day Limit for their provisioned number. If the Provisioning call is made several times within that 30-Day period, it will return the `expiryDate` in the Unix format and will not add any activeDays until after that `expiryDate`.
> 
> For paid apps, a provisioned number can be allotted for a maximum of 5 years. If a Provisioning call is made which will result to activeDays > 1830, the response body will indicate that the provisioned number is already valid for more than 5 years.
> 


```ruby
def create_subscription(body); end
```

#### Parameters

| Parameter | Tags | Description |
|-----------|------|-------------|
| body |  ``` Required ```  | A JSON payload containing the required attributes |


#### Example Usage

```ruby
body = ProvisionNumberRequest.new

result = provisioning_controller.create_subscription(body)

```

#### Errors

| Error Code | Error Description |
|------------|-------------------|
| 400 | Invalid or missing request parameters |
| 401 | Invalid access token. Please try with a valid token |
| 403 | Authorization credentials passed and accepted but account does not have permission<br> SpikeArrest-The API call rate limit has been exceeded |
| 404 | The requested URI does not exist<br> RESOURCE-NOT-FOUND<br> |
| 500 | Technical error : Unable to route the message to a Target Endpoint : An error has occurred while processing your request, please refer to API Docs for summary on the issue<br> |
| 0 | An internal error occurred when processing the request |



### <a name="get_subscription"></a>![Method: ](https://apidocs.io/img/method.png ".ProvisioningController.get_subscription") get_subscription

> Get mobile number subscription for an account
> 


```ruby
def get_subscription; end
```

#### Example Usage

```ruby

result = provisioning_controller.get_subscription()

```

#### Errors

| Error Code | Error Description |
|------------|-------------------|
| 400 | Invalid or missing request parameters |
| 401 | Invalid access token. Please try with a valid token |
| 403 | Authorization credentials passed and accepted but account does not have permission<br> SpikeArrest-The API call rate limit has been exceeded |
| 404 | The requested URI does not exist<br> RESOURCE-NOT-FOUND |
| 500 | Technical error : Unable to route the message to a Target Endpoint : An error has occurred while processing your request, please refer to API Docs for summary on the issue |
| 0 | An internal error occurred when processing the request |



### <a name="delete_subscription"></a>![Method: ](https://apidocs.io/img/method.png ".ProvisioningController.delete_subscription") delete_subscription

> Delete a mobile number subscription from an account
> 


```ruby
def delete_subscription(body); end
```

#### Parameters

| Parameter | Tags | Description |
|-----------|------|-------------|
| body |  ``` Required ```  | EmptyArr |


#### Example Usage

```ruby
body = DeleteNumberRequest.new

provisioning_controller.delete_subscription(body)

```

#### Errors

| Error Code | Error Description |
|------------|-------------------|
| 400 | Invalid or missing request parameters |
| 401 | Invalid access token. Please try with a valid token |
| 403 | Authorization credentials passed and accepted but account does not have permission<br> SpikeArrest-The API call rate limit has been exceeded |
| 404 | The requested URI does not exist<br> RESOURCE-NOT-FOUND |
| 500 | Technical error : Unable to route the message to a Target Endpoint : An error has occurred while processing your request, please refer to API Docs for summary on the issue |
| 0 | An internal error occurred when processing the request |



[Back to List of Controllers](#list_of_controllers)

## <a name="messaging_controller"></a>![Class: ](https://apidocs.io/img/class.png ".MessagingController") MessagingController

### Get singleton instance

The singleton instance of the ``` MessagingController ``` class can be accessed from the API Client.

```ruby
messaging_controller = client.messaging
```

### <a name="create_send_sms"></a>![Method: ](https://apidocs.io/img/method.png ".MessagingController.create_send_sms") create_send_sms

> Send an SMS Message to a single or multiple mobile number/s.
> 


```ruby
def create_send_sms(payload); end
```

#### Parameters

| Parameter | Tags | Description |
|-----------|------|-------------|
| payload |  ``` Required ```  | A JSON or XML payload containing the recipient's phone number and text message.
This number can be in international format if preceeded by a '+' or in national format ('04xxxxxxxx') where x is a digit. |


#### Example Usage

```ruby
payload = SendSMSRequest.new

result = messaging_controller.create_send_sms(payload)

```

#### Errors

| Error Code | Error Description |
|------------|-------------------|
| 400 | Invalid or missing request parameters<br>TO-MSISDN-NOT-VALID<br>SENDER-MISSING<br>DELIVERY-IMPOSSIBLE<br>FROM-MSISDN-TOO-LONG<br>BODY-TOO-LONG<br>BODY-MISSING<br>TO-MSISDN-TOO-LONG<br>TECH-ERR<br>BODY-NOT-VALID<br>NOT-PROVISIONED<br>Request flagged as containing suspicious content<br> |
| 401 | Invalid access token. Please try with a valid token |
| 403 | Authorization credentials passed and accepted but account does not have permission<br>SpikeArrest-The API call rate limit has been exceeded<br> |
| 404 | The requested URI does not exist<br>RESOURCE-NOT-FOUND<br> |
| 405 | The requested resource does not support the supplied verb |
| 415 | API does not support the requested content type |
| 422 | The request is formed correctly, but due to some condition the request cannot be processed e.g. email is required and it is not provided in the request<br> |
| 500 | Technical error : Unable to route the message to a Target Endpoint :<br>An error has occurred while processing your request, please refer to API Docs for summary on the issue<br> |
| 501 | The HTTP method being used has not yet been implemented for<br>the requested resource<br> |
| 503 | The service requested is currently unavailable |
| 0 | An internal error occurred when processing the request |



### <a name="retrieve_sms_responses"></a>![Method: ](https://apidocs.io/img/method.png ".MessagingController.retrieve_sms_responses") retrieve_sms_responses

> Messages are retrieved one at a time, starting with the earliest response.
> The API supports the encoding of the full range of emojis in the reply message. The emojis will be in their UTF-8 format.
> If the subscription has a `notifyURL`, response messages will be logged there instead.
> 
> # Notification URL Format for SMS Response
> 
> <pre><code class="language-sh">{
>   "to":"+61472880123",
>   "from":"+61412345678",
>   "body":"Foo4",
>   "sentTimestamp":"2018-04-20T14:24:35",
>   "messageId":"DMASApiA0000000146"
> }</code></pre>
> 
> The fields are:
> | Field | Description |
> | --- |--- |
> | `to` | The number the message was sent to. |
> | `from` | The number the message was sent from. |
> | `body` | The content of the SMS response. |
> | `sentTimestamp` | Time handling of the message ended. |
> | `messageId` | The ID assigned to the message. |
> 


```ruby
def retrieve_sms_responses; end
```

#### Example Usage

```ruby

result = messaging_controller.retrieve_sms_responses()

```

#### Errors

| Error Code | Error Description |
|------------|-------------------|
| 400 | Invalid or missing request parameters<br>NOT-PROVISIONED<br>Request flagged as containing suspicious content<br> |
| 401 | Invalid access token. Please try with a valid token |
| 403 | Authorization credentials passed and accepted but account does not have permission<br>SpikeArrest-The API call rate limit has been exceeded<br> |
| 404 | The requested URI does not exist<br>RESOURCE-NOT-FOUND<br> |
| 405 | The requested resource does not support the supplied verb |
| 415 | API does not support the requested content type |
| 422 | The request is formed correctly, but due to some condition the<br>request cannot be processed e.g. email is required and it is not<br>provided in the request<br> |
| 500 | Technical error : Unable to route the message to a Target Endpoint :<br>An error has occurred while processing your request, please refer to<br>API Docs for summary on the issue<br> |
| 501 | The HTTP method being used has not yet been implemented for<br>the requested resource<br> |
| 503 | The service requested is currently unavailable |
| 0 | An internal error occurred when processing the request |



### <a name="get_sms_status"></a>![Method: ](https://apidocs.io/img/method.png ".MessagingController.get_sms_status") get_sms_status

> If no notification URL has been specified, it is possible to poll for the message status.
> Note that the `MessageId` that appears in the URL must be URL encoded. Just copying the `MessageId` as it was supplied when submitting the message may not work.
> 
> SMS Status with Notification URL
> ---
> When a message has reached its final state, the API will send a POST to the URL that has been previously specified.
> <pre><code class="language-sh">{
>     to: '+61418123456'
>     sentTimestamp: '2017-03-17T10:05:22+10:00'
>     receivedTimestamp: '2017-03-17T10:05:23+10:00'
>     messageId: /cccb284200035236000000000ee9d074019e0301/1261418123456
>     deliveryStatus: DELIVRD
>   }
> </code></pre>
> 
> The fields are:
> <table>
>   <thead>
>     <tr>
>       <th>Field</th>
>       <th>Description</th>
>     </tr>
>   </thead>
>   <tbody>
>     <tr>
>       <td><code>to</code></td>
>       <td>The number the message was sent to.</td>
>     </tr>
>     <tr>
>       <td><code>receivedTimestamp</code></td>
>       <td>Time the message was sent to the API.</td>
>     </tr>
>     <tr>
>       <td><code>sentTimestamp</code></td>
>       <td>Time handling of the message ended.</td>
>     </tr>
>     <tr>
>       <td><code>deliveryStatus</code></td>
>       <td>The final state of the message.</td>
>     </tr>
>     <tr>
>       <td><code>messageId</code></td>
>       <td>The same reference that was returned when the original message was sent.</td>
>     </tr>
>     <tr>
>       <td><code>receivedTimestamp</code></td>
>       <td>Time the message was sent to the API.</td>
>     </tr>
>   </tbody>
> </table>
> 
> Upon receiving this call it is expected that your servers will give a 204 (No Content) response.
> Anything else will cause the API to reattempt the call 5 minutes later.
> 


```ruby
def get_sms_status(message_id); end
```

#### Parameters

| Parameter | Tags | Description |
|-----------|------|-------------|
| message_id |  ``` Required ```  | Unique identifier of a message - it is the value returned from a
previous POST call to https://api.telstra.com/v2/messages/sms. |


#### Example Usage

```ruby
message_id = 'messageId'

result = messaging_controller.get_sms_status(message_id)

```

#### Errors

| Error Code | Error Description |
|------------|-------------------|
| 400 | Invalid or missing request parameters<br> NOT-PROVISIONED<br> Request flagged as containing suspicious content |
| 401 | Invalid access token. Please try with a valid token |
| 403 | Authorization credentials passed and accepted but account does<br>not have permission<br> SpikeArrest-The API call rate limit has been exceeded |
| 404 | The requested URI does not exist<br> OLD-NONEXISTANT-MESSAGE-ID<br> RESOURCE-NOT-FOUND |
| 405 | The requested resource does not support the supplied verb |
| 415 | API does not support the requested content type |
| 422 | The request is formed correctly, but due to some condition the request cannot be processed e.g. email is required and it is not provided in the request<br> |
| 500 | Technical error : Unable to route the message to a Target Endpoint :<br>An error has occurred while processing your request, please refer to<br>API Docs for summary on the issue<br> |
| 501 | The HTTP method being used has not yet been implemented for the requested resource<br> |
| 503 | The service requested is currently unavailable |
| 0 | An internal error occurred when processing the request |



### <a name="create_send_mms"></a>![Method: ](https://apidocs.io/img/method.png ".MessagingController.create_send_mms") create_send_mms

> Send MMS


```ruby
def create_send_mms(body); end
```

#### Parameters

| Parameter | Tags | Description |
|-----------|------|-------------|
| body |  ``` Required ```  | A JSON or XML payload containing the recipient's phone number and MMS message.
The recipient number should be in the format '04xxxxxxxx' where x is a digit. |


#### Example Usage

```ruby
body = SendMMSRequest.new

result = messaging_controller.create_send_mms(body)

```

#### Errors

| Error Code | Error Description |
|------------|-------------------|
| 400 | Invalid or missing request parameters<br>MMS-TYPE-MISSING<br>MMS-PAYLOAD-MISSING<br>MMS-FILENAME-MISSING<br>DELIVERY-IMPOSSIBLE<br>TO-MSISDN-NOT-VALID<br>SENDER-MISSING<br>DELIVERY-IMPOSSIBLE<br>SUBJECT-TOO-LONG<br>FROM-MSISDN-TOO-LONG<br>TO-MSISDN-TOO-LONG<br>NOT-PROVISIONED<br>Request flagged as containing suspicious content<br> |
| 401 | Invalid access token. Please try with a valid token |
| 403 | Authorization credentials passed and accepted but account does not have permission<br>SpikeArrest-The API call rate limit has been exceeded<br> |
| 404 | The requested URI does not exist<br>RESOURCE-NOT-FOUND<br> |
| 405 | The requested resource does not support the supplied verb |
| 415 | API does not support the requested content type |
| 422 | The request is formed correctly, but due to some condition the request cannot be processed e.g. email is required and it is not provided in the request<br> |
| 500 | Technical error : Unable to route the message to a Target Endpoint :<br>An error has occurred while processing your request, please refer to API Docs for summary on the issue<br> |
| 501 | The HTTP method being used has not yet been implemented for<br>the requested resource<br> |
| 503 | The service requested is currently unavailable |
| 0 | An internal error occurred when processing the request |



### <a name="retrieve_mms_responses"></a>![Method: ](https://apidocs.io/img/method.png ".MessagingController.retrieve_mms_responses") retrieve_mms_responses

> Messages are retrieved one at a time, starting with the earliest response.
> If the subscription has a `notifyURL`, response messages will be logged there instead.
> 
> # Notification URL Format for MMS Replies
> 
> <pre><code class="language-sh">{
>   "status": "RECEIVED",
>   "destinationAddress": "+61418123456",
>   "senderAddress": "+61421987654",
>   "subject": "Foo",
>   "sentTimestamp": "2018-03-23T12:15:45+10:00",
>   "envelope": "string",
>   "MMSContent":
>     [
>       {
>         "type": "text/plain",
>         "filename": "text_1.txt",
>         "payload": "string"
>       },
>       {
>         "type": "image/jpeg",
>         "filename": "sample.jpeg",
>         "payload": "string"
>       }
>     ]
> }</code></pre>
> 
> The fields are:
> | Field | Description |
> | --- | --- |
> | `status` | The final state of the message. |
> | `destinationAddress` |The number the message was sent to. |
> | `senderAddress` | The number the message was sent from. |
> | `subject` | The subject assigned to the message. |
> | `sentTimestamp` | Time handling of the message ended. |
> | `envelope` | Information about about terminal type and originating operator. |
> | `MMSContent` | An array of the actual content of the reply message. |
> | `type` | The content type of the message. |
> | `filename` | The filename for the message content. |
> | `payload` | The content of the message. |
> 


```ruby
def retrieve_mms_responses; end
```

#### Example Usage

```ruby

result = messaging_controller.retrieve_mms_responses()

```

#### Errors

| Error Code | Error Description |
|------------|-------------------|
| 400 | Invalid or missing request parameters<br>NOT-PROVISIONED<br>Request flagged as containing suspicious content<br> |
| 401 | Invalid access token. Please try with a valid token |
| 403 | Authorization credentials passed and accepted but account does not have permission<br>SpikeArrest-The API call rate limit has been exceeded<br> |
| 404 | The requested URI does not exist<br>RESOURCE-NOT-FOUND<br> |
| 405 | The requested resource does not support the supplied verb |
| 415 | API does not support the requested content type |
| 422 | The request is formed correctly, but due to some condition the<br>request cannot be processed e.g. email is required and it is not<br>provided in the request<br> |
| 500 | Technical error : Unable to route the message to a Target Endpoint :<br>An error has occurred while processing your request, please refer to<br>API Docs for summary on the issue<br> |
| 501 | The HTTP method being used has not yet been implemented for<br>the requested resource<br> |
| 503 | The service requested is currently unavailable |
| 0 | An internal error occurred when processing the request |



### <a name="get_mms_status"></a>![Method: ](https://apidocs.io/img/method.png ".MessagingController.get_mms_status") get_mms_status

> Get MMS Status


```ruby
def get_mms_status(messageid); end
```

#### Parameters

| Parameter | Tags | Description |
|-----------|------|-------------|
| messageid |  ``` Required ```  | Unique identifier of a message - it is the value returned from
a previous POST call to https://api.telstra.com/v2/messages/mms |


#### Example Usage

```ruby
messageid = 'messageid'

result = messaging_controller.get_mms_status(messageid)

```

#### Errors

| Error Code | Error Description |
|------------|-------------------|
| 400 | Invalid or missing request parameters<br> NOT-PROVISIONED<br> Request flagged as containing suspicious content |
| 401 | Invalid access token. Please try with a valid token |
| 403 | Authorization credentials passed and accepted but account does not have permission<br>SpikeArrest-The API call rate limit has been exceeded<br> |
| 404 | The requested URI does not exist<br>OLD-NONEXISTANT-MESSAGE-ID<br>RESOURCE-NOT-FOUND<br> |
| 405 | The requested resource does not support the supplied verb |
| 415 | API does not support the requested content type |
| 422 | The request is formed correctly, but due to some condition the request cannot be processed e.g. email is required and it is not provided in the request<br> |
| 500 | Technical error : Unable to route the message to a Target Endpoint :<br>An error has occurred while processing your request, please refer to API Docs for summary on the issue<br> |
| 501 | The HTTP method being used has not yet been implemented for<br>the requested resource<br> |
| 503 | The service requested is currently unavailable |
| 0 | An internal error occurred when processing the request |



[Back to List of Controllers](#list_of_controllers)



