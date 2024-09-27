//
//  NaverMapView.swift
//  HotPlace
//
//  Created by 60192229 on 8/5/24.
//

import SwiftUI
import NMapsMap

struct NaverMapView: UIViewRepresentable {
    let naverMapView = NMFNaverMapView()
    var markerArray : [NMFMarker] = []                  // 스토어마커들 모음
    
    @Binding var selectedMarker: NMFMarker?             // 선택된 스토어 마커
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        naverMapView.mapView.mapType = .basic
        naverMapView.mapView.setLayerGroup(NMF_LAYER_GROUP_TRANSIT, isEnabled: true) // 대중교통 노출
        naverMapView.mapView.isIndoorMapEnabled = true // 실내지도 활성화, (ex. 백화점 내부, 지하상가 내부 등),
        naverMapView.showIndoorLevelPicker = true // 실내지도 층별 표시 기능
        naverMapView.mapView.positionMode = .direction
        naverMapView.showLocationButton = false
        naverMapView.showZoomControls = false // 줌 버튼 비활성화
        naverMapView.mapView.addCameraDelegate(delegate: context.coordinator)
        naverMapView.mapView.touchDelegate = context.coordinator
        naverMapView.mapView.logoAlign = NMFLogoAlign.leftBottom
        naverMapView.mapView.logoInteractionEnabled = true
        naverMapView.showScaleBar = false
        naverMapView.mapView.isRotateGestureEnabled = false
        //naverMapView.mapView.isTiltGestureEnabled = false
        naverMapView.mapView.minZoomLevel = 4.5
        naverMapView.mapView.latitude = AppConstants.mapDefaultLocation.lat
        naverMapView.mapView.longitude = AppConstants.mapDefaultLocation.lng
        naverMapView.mapView.extent = AppConstants.mapLimitBounds        // map 지역 범위 한계 설정.
    //self.setAllMarkers()
        
        return naverMapView
    }

    class Coordinator: NSObject, NMFMapViewCameraDelegate, NMFOverlayImageDataSource, NMFMapViewTouchDelegate {
        var parent: NaverMapView
        
        deinit {
            Logger.log("", logType: .info)
        }
        
        init(_ parent: NaverMapView) {
            Logger.log("", logType: .info)
            self.parent = parent
        }
        
        // MARK: - NMFMapViewCameraDelegate
        func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
            Logger.log("Zoom Level: \(Int(mapView.zoomLevel))")

            switch reason {
            case NMFMapChangedByDeveloper: // 개발자가 API를 호출해 카메라가 움직였음을 나타내는 값.
                break
            case NMFMapChangedByGesture: // 사용자의 제스처로 인해 카메라가 움직였음을 나타내는 값.
                self.resetSelectedMarker()
                //self.showContainerView(mode: self.isSearchMode ? .stores : .photos, size: .hide, isNew: false)
                break
            case NMFMapChangedByControl: // 사용자의 버튼 선택으로 인해 카메라가 움직였음을 나타내는 값.
                break
            case NMFMapChangedByLocation: // 위치 정보 갱신으로 카메라가 움직였음을 나타내는 값.
                break
            default:
                break
            }
        }

        // MARK: - NMFOverlayImageDataSource
        func view(with overlay: NMFOverlay) -> UIView {
            let markerOverlay = overlay as? NMFMarker
            let markerView = UIImageView(frame: CGRect(x: 0, y: 0, width: markerOverlay?.iconImage.imageWidth ?? 0, height: markerOverlay?.iconImage.imageHeight ?? 0))
            markerView.image = markerOverlay?.iconImage.image.withTintColor(markerOverlay?.iconTintColor ?? .green)
            return markerView
        }

        // MARK: - NMFMapViewTouchDelegate
        func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
            Logger.log("*** did tap map")
            self.moveCamera(location: latlng)
            //self.resetSelectedMarker()
            //self.showContainerView(mode: .photos, size: .hide)
            // 스토어 목록보기 테스트용
            //let marker = NMFMarker(position: NMGLatLng(lat: latlng.lat, lng: latlng.lng))
            //marker.tag = 0
            //self.selectedLocationMarker = marker
            //self.markerArray.append(marker)
            //self.showContainerView(mode: self.isSearchMode ? .stores : .photos, size: self.isSearchMode ? .hide : .small, isNew: true)
        }
        
        func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
            Logger.log("*** did tap symbol \(String(describing: symbol.caption))")
            if symbol.caption != "" {
                self.resetSelectedMarker()
                
                self.moveCamera(location: symbol.position)
                let marker = NMFMarker(position: NMGLatLng(lat: symbol.position.lat, lng: symbol.position.lng))
                marker.mapView = parent.naverMapView.mapView
                marker.iconImage = NMFOverlayImage(image: #imageLiteral(resourceName: "poi_marker"))
                // caption 저장용도로 사용...
                marker.captionText = symbol.caption
                marker.captionTextSize = 0
                marker.isForceShowIcon = true
                marker.zIndex = 100
                marker.tag = 0
                
                parent.selectedMarker = marker
                parent.markerArray.append(marker)
                //parent.showContainerView(mode: .poi, size: .small, isNew: true)
                
                return true
            }
            else {
                return false
            }
        }
        
        // MARK: - MAP
        func moveCamera(lat: Double, lng: Double, animated: Bool = true) {
            self.moveCamera(location: NMGLatLng(lat: lat, lng: lng), animated: animated)
        }
        
        func moveCamera(location: NMGLatLng, zoomLevel: Double? = nil, animated: Bool = true) {
            let cameraUpdate = NMFCameraUpdate(scrollTo: location, zoomTo: zoomLevel ?? parent.naverMapView.mapView.zoomLevel)
            if animated {
                cameraUpdate.animation = .easeIn
                cameraUpdate.animationDuration = 0.5
            }
            parent.naverMapView.mapView.moveCamera(cameraUpdate) { _ in
                //self.myLocationButton.setImage(#imageLiteral(resourceName: "location_black"), for: .normal)
            }
        }
        
        func resetSelectedMarker() {
            if let marker = parent.selectedMarker {
                marker.mapView = nil
                // POI 아닌경우
                if marker.tag > 0 { //}, let store = DatabaseManager().selectStore(seq: Int(marker.tag)) {
                    //let unselectedLocationMarkerImage = UIImage(named: String(format:"marker_%02d", store.markerCode) ) ?? #imageLiteral(resourceName: "menu_hot_map")
                    //parent.selectedLocationMarker?.iconImage = NMFOverlayImage(image: unselectedLocationMarkerImage)
                    parent.selectedMarker?.mapView = parent.naverMapView.mapView
                    parent.selectedMarker?.captionText = ""
                    parent.selectedMarker?.isForceShowIcon = false
                    parent.selectedMarker?.zIndex = 10
                }
            }
            parent.selectedMarker = nil
        }
    }
}
