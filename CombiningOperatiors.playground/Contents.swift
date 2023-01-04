import UIKit
import RxSwift

let disposeBag = DisposeBag()

print("-----------startWith---------")

let 노랑반 = Observable<String>.of("👧🏼", "🧒🏻", "👦🏽")

노랑반
    .enumerated()
    .map({ index, element in
            return element + "어린이" + "\(index)"
    })
    .startWith("👨🏻선생님")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----------concat1---------")

let 노랑반어린이들 = Observable<String>.of("👧🏼", "🧒🏻", "👦🏽")
let 선생님 = Observable<String>.of("👨🏻선생님")

let 줄서서걷기 = Observable
    .concat([선생님, 노랑반어린이들])

줄서서걷기
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----------concat1-1---------")
선생님
    .concat(노랑반어린이들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----------concatMap---------")
let 어린이집: [String: Observable<String>] = [
    "노랑반": Observable.of("👧🏼", "🧒🏻", "👦🏽"),
    "파랑반": Observable.of("🧑🏻‍🔧", "👩🏾‍🚒")
]
Observable.of("노랑반", "파랑반")
    .concatMap { 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
