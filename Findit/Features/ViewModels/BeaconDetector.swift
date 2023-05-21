//
//  RangeBeacon.swift
//  Findit
//
//  Created by Ivan on 21/05/23.
//

import Foundation
import CoreLocation

class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate {
    // The accuracy of the proximity value, measured in meters from the beacon.
    @Published var lastDistance: CLLocationAccuracy = 0
    // Constants that reflect the relative distance to a beacon.
    @Published var lastProximity: CLProximity = CLProximity.unknown
    
    // central place to manage your app’s location-related behaviors.
    var locationManager: CLLocationManager?
    
    // hardcoded UUID for debug purpose
    private var beaconUUID = "cb10023f-a318-3394-4199-a8730c7c1aec"
    private var beaconMajor: UInt16 = 222
    private var beaconMinor: UInt16 = 155
    
    private var beaconConstraint: CLBeaconIdentityConstraint?
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    deinit {
        // Stop monitoring when the view disappears.
        if let monitoredRegions = locationManager?.monitoredRegions {
            for region in monitoredRegions {
                locationManager?.stopMonitoring(for: region)
            }
        }

        // Stop ranging when the view disappears.
        if let constraint = beaconConstraint {
            locationManager?.stopRangingBeacons(satisfying: constraint)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // scan for Beacon
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            } else {
                print("Monitoring is not available")
            }
        } else {
            print("Unauthorized: \(status)")
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
//        let beaconRegion = region as? CLBeaconRegion
//        if state == .inside {
//            print("inside")
//            // Start ranging when inside a region.
//            locationManager?.startRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
//        } else {
//            print("outside")
//            // Stop ranging when not inside a region.
//            locationManager?.stopRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
//        }
//    }
    
    /** A callback to tell whether the beacon is in range */
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        print("total beacons \(beacons.count)")
        if let beacon = beacons.first {
            print("proximity: \(beacon.proximity)")
            print("distance: \(beacon.accuracy)")
            update(proximity: beacon.proximity, distance: beacon.accuracy)
        } else {
            update(proximity: .unknown, distance: 0)
        }
    }
    
    /**
        start scanning and configure a Beacon
     */
    func startScanning() {
        /**
            A constraint specifies beacon identity characteristics.
            Before detecting Beacon, we must specify identities values that programmed in the beacon hardware (e.g proximity UUID, major, minor)
         */
        let uuid = UUID(uuidString: beaconUUID)!
        let constraint = CLBeaconIdentityConstraint(
            uuid: uuid,
            major: beaconMajor,
            minor: beaconMinor
        )
        beaconConstraint = constraint
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: uuid.uuidString)
        
        // To detect when a beacon is in range
        locationManager?.startMonitoring(for: beaconRegion)
        // To determine the relative distance to the beacon
        locationManager?.startRangingBeacons(satisfying: constraint )
    }
    
    func update(proximity: CLProximity, distance: CLLocationAccuracy) {
        lastProximity = proximity
        lastDistance = distance
    }
}
