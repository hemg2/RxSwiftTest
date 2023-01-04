import UIKit
import RxSwift

print("------Just-------")
Observable<Int>.just(1)  // 정의만 한다 그렇기에 서브스크립이 필요하다
    .subscribe(onNext: { // 이벤트를 방출 시키는것
        print($0)
    })

/*
 Observable(옵저버블)의 생명주기
1.Create  크리에이트된다.
2.subscribe 서브스크라입 된다.
3.onNext 넥스트로 데이터가 전달된다. 넥트스로 전달될수도있고 에러가 날수도있다. 에러가나면 에러에서 끝난다.
4. onCompleted 컴플릿되고 끝이 난다.
5. Disposed 디스포즈 된다. (끝부분)
 
 */

print("------Of1-------")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })



print("------Of2-------")
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })


print("------From-------")
Observable.from([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })


print("------subscribe1-------")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }


print("------subscribe2-------")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }


print("------subscribe3-------")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })


print("----------empty----------")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }

print("----------naver----------")
Observable<Void>.never()
    .debug("naver")
    .subscribe(onNext: {
        print($0)
    },
               onCompleted: {
        print("com")
    })


print("--------range--------")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2*\($0)=\(2*$0)")
    })


print("--------dispose--------")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })
    .dispose()


print("-------disposeBag--------")
let disposeBag = DisposeBag()

Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)


print("--------create1--------")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)


print("--------create2--------")
enum MyError: Error {
    case anError
}

Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
onNext: {
    print($0)
},
onError: {
    print($0.localizedDescription)
},
onDisposed: {
    print("disposed")
}
)
.disposed(by: disposeBag)


print("--------defferd1--------")
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("--------defferd2--------")
var 뒤집기: Bool = false

let fatory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("이거다")
    } else {
        return Observable.of("다른거다")
    }
}

for i in 0...3 {
    fatory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}
