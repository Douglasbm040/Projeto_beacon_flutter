//#define ARDUINOJSON_ENABLE_COMMENTS 1
#include <ArduinoJson.h>
#include <Preferences.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
#include <string>
#include <nvs_flash.h>

using namespace std;
//using std::string;

String json;

String id;
bool deviceConnected = false;
bool oldDeviceConnected = false;


// instanciando server
BLEServer* pServer = NULL;
BLECharacteristic* pCharacteristic = NULL;

// intanciando a preferencia
Preferences preferences;


// See the following for generating UUIDs:
// https://www.uuidgenerator.net/

#define SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"


class MyServerCallbacks: public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      deviceConnected = true;
      BLEDevice::startAdvertising();
    };

    void onDisconnect(BLEServer* pServer) {
      deviceConnected = false;
    }
};
class MyCallbacks: public BLECharacteristicCallbacks {
    void onWrite(BLECharacteristic *pCharacteristic) {
      std::string rxValue = pCharacteristic->getValue();
      

      if (rxValue.length() > 0) {
        Serial.println("*********");
        Serial.print("Received Value: ");
        char values[rxValue.length()];
        Serial.println(rxValue.length());
        String response = "";
        for (int i = 0; i < rxValue.length(); i++){
          //values[i] = rxValue+[i];
          response += rxValue[i];
          Serial.print(rxValue[i]);
        }
        Serial.println(response);
        Serial.println("--------------");
        //char values[] = response ;
        //Serial.println(values);
        //Serial.println(id);
        StaticJsonDocument<200> doc;
        DeserializationError error = deserializeJson(doc, response);
        // Test if parsing succeeds.
        if (error) {
        Serial.print(F("deserializeJson() failed: "));
        Serial.println(error.f_str());
        return;
        }
        json = doc.as<String>() ;
        String deviceName  = doc["n"].as<String>() ;
        preferences.putString("key_json",json);
        preferences.putString("key_data",deviceName);

        //id = preferences.putString("key_data",result);
        Serial.println(response);
        ESP.restart();
        Serial.println("*********");
      }
    }
};




void setup() {
  Serial.begin(115200);
  nvs_flash_init();
  preferences.begin("Pres",false);

  id = preferences.getString("key_data","esp32");
  // Create the BLE Device
  BLEDevice::init(id.c_str());
  

  // Create the BLE Server
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // Create the BLE Service
  BLEService *pService = pServer->createService(SERVICE_UUID);

  // Create a BLE Characteristic
  pCharacteristic = pService->createCharacteristic(
                      CHARACTERISTIC_UUID,
                      BLECharacteristic::PROPERTY_READ   |
                      BLECharacteristic::PROPERTY_WRITE  |
                      BLECharacteristic::PROPERTY_NOTIFY |
                      BLECharacteristic::PROPERTY_INDICATE
                    );

  // https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.descriptor.gatt.client_characteristic_configuration.xml
  // Create a BLE Descriptor
  pCharacteristic->addDescriptor(new BLE2902());

  pCharacteristic->setCallbacks(new MyCallbacks());

  // Start the service
  pService->start();

  // Start advertising
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(false);
  pAdvertising->setMinPreferred(0x0);  // set value to 0x00 to not advertise this parameter
  BLEDevice::startAdvertising();
  Serial.println("Waiting a client connection to notify...");
}

void loop() {
    // notify changed value
    if (deviceConnected) {
      while(true){
        json = preferences.getString("key_json","null");
        pCharacteristic->setValue(json.c_str());
        pCharacteristic->notify();
        delay(10); // bluetooth stack will go into congestion, if too many packets are sent, in 6 hours test i was able to go as low as 3ms
      }
    }
    // disconnecting
    if (!deviceConnected && oldDeviceConnected) {
        delay(500); // give the bluetooth stack the chance to get things ready
        pServer->startAdvertising(); // restart advertising
        Serial.println("start advertising");
        oldDeviceConnected = deviceConnected;
    }
    // connecting
    if (deviceConnected && !oldDeviceConnected) {
        // do stuff here on connecting
        oldDeviceConnected = deviceConnected;
    }
}
