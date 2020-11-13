//
//  BaiTap2ViewModel.swift
//  PhongNguyenDucBaiTap
//
//  Created by TTC Training on 11/13/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaiTap2ViewModel {
    var disposeBag = DisposeBag()
    let baseRequest = BaseRequest()
    let listDangChoVay = BehaviorRelay<[VayNoBO]>(value: [])
    let listDangVay = BehaviorRelay<[VayNoBO]>(value: [])
    var listObjectDangChoVay = BehaviorRelay<[VayNoBO]>(value: [])
    var listObjectDangVay = BehaviorRelay<[VayNoBO]>(value: [])
    
    func getDangChoVayData() {
        self.baseRequest.requestUrl(url: "https://mockapi.superoffice.vn/api/baitap2/getDangChoVay",
                                    type: VayNoContainerBO.self) { (array) in
                                        self.listDangChoVay.accept(array.dangChoVayData)
                                        self.listDangChoVay.bind(to: self.listObjectDangChoVay).disposed(by: self.disposeBag)
        }
    }
    
    func getDangVayData() {
        self.baseRequest.requestUrl(url: "https://mockapi.superoffice.vn/api/baitap2/dangVay",
                                    type: VayNoContainerBO.self) { (array) in
                                        self.listDangVay.accept(array.dangVayData)
                                        self.listDangVay.bind(to: self.listObjectDangVay).disposed(by: self.disposeBag)
        }
    }
}
