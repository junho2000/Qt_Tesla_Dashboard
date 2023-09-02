import QtQuick 2.2
import com.example 1.0

//! [0]
Item {
    id: valueSource
    property real kph: 0 //speed(cm/s)
    property real rpm: 0 //piracer wheel rpm
    property real fuel: 0 //battery
    property real temperature: 0 //distance
    property real odo: 0
    property real travelableDis:0

    property string gear: {
        if (kph == 0) {
            return "P";
        }
        else if (kph < 10) {
            return "1";
        }
        else if (kph < 20) {
            return "2";
        }
        else if (kph < 30) {
            return "3";
        }
        else if (kph < 40) {
            return "4";
        }
        else if (kph < 50) {
            return "5";
        }
        else {
            return "6"; // Assuming there is a gear 6 for speeds higher than 160 kph
        }
    }


    DBusManager {
        id: dbusmanager
        onSpeedChanged: {
            valueSource.kph = dbusmanager.getSpeed() // Update kph property when speed changes
            valueSource.rpm = dbusmanager.getRPM() / 10
        }
        onDistanceChanged: {
            valueSource.temperature = dbusmanager.getDistance() / 100 // Update kph property when speed changes
        }
        onBatteryChanged: {
            valueSource.fuel = dbusmanager.getBattery() // Update kph property when speed changes
        }
        onOdoChanged: {
            valueSource.odo = dbusmanager.getODO()
        }
        onTravelableDisChanged: {
            valueSource.travelableDis = dbusmanager.getTravelableDis()
        }
    }
 }
