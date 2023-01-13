import UIKit
import RxSwift
 
//print("------Just-------")  // 저스트는 이름에서 보듯이 하나의 엘리멘탈을 방출하는것 하나의 요소를 포함한것을
//Observable<Int>.just(1)  // 정의만 한다 그렇기에 서브스크립이 필요하다
//    .subscribe(onNext: { // 이벤트를 방출 시키는것
//        print($0)
//    })
//print("------Just1-------")
//Observable.just(1)
//    .subscribe(onNext: {
//        print($0)
//    })

/*
 Observable(옵저버블)의 생명주기
1.Create  크리에이트된다.
2.subscribe 서브스크라입 된다.
3.onNext 넥스트로 데이터가 전달된다. 넥트스로 전달될수도있고 에러가 날수도있다. 에러가나면 에러에서 끝난다.
4. onCompleted 컴플릿되고 끝이 난다.
5. Disposed 디스포즈 된다. (끝부분)
 
 - Observable은 어떤 구성요소를 가지는 next 이벤트를 계속해서 방출할 수 있다.
 - Observable은 error 이벤트를 방출하여 완전 종료될 수 있다.
 - Observable은 complete 이벤트를 방출하여 완전 종료 될 수 있다.

 Observable 이란?
 Rx의 심장 같은 존재
 Observable = Observable Sequence = Sequence
 비동기적(asynchronous)
 Observable 들은 일정기간 동안 계속해서 이벤트를 생성(emit)
 marble diagram: 시간의 흐름에 따라서 값을 표시하는 방식
 
 
 추가적으로
 dispose - 구독 취소
옵저버블를 정의(생성)를 하고  서브스크립트로 구독하면 디스포즈 시켜서 메모리 누수되는걸 작동시켜야한다.
이의 순서가 생명 주기이다.
 disposed(by: disposeBag) 디스포즈를 해야한다. 생명주기다. 메모리가 누수될수있기때문에
 */



//print("------Of1-------") // 오브는 다양한 형태의 이벤트가 가능하다 하나 이상을 가능하게함
//Observable<Int>.of(1, 2, 3, 4, 5)
//    .subscribe(onNext: {
//        print($0)
//    })
//
//
//
//print("------Of2-------")// 오저버블은 타입추론을 통해서 옵저버블 시퀀스를 생성한다.
//Observable.of([1, 2, 3, 4, 5]) // <>인 타입추론이 없어도 방출한다. 배열1개는 저스트도 가능하다
//    .subscribe(onNext: {
//        print($0)
//    })


//print("------From-------")
//Observable.from([1, 2, 3, 4, 5])  // 프롬은 어레이를 받는다 하나씩 방출한다
//    .subscribe(onNext: {
//        print($0)
//    })
//

//print("------subscribe1-------")
//Observable.of(1, 2, 3)
//    .subscribe {
//        print($0)
//    }
//
//
//print("------subscribe2-------")
//Observable.of(1, 2, 3)
//    .subscribe {
//        if let element = $0.element {
//            print(element)
//        }
//    }
//
//
//print("------subscribe3-------")
//Observable.of(1, 2, 3)
//    .subscribe(onNext: {
//        print($0)
//    })


//print("----------empty----------")
//Observable<Void>.empty()
//    .subscribe {
//        print($0)
//    }
//
//print("----------naver----------")
//Observable<Void>.never()
//    .debug("naver")
//    .subscribe(onNext: {
//        print($0)
//    },
//               onCompleted: {
//        print("com")
//    })
//

//print("--------range--------") // 구구단 2단이 나타난다 포문과 비슷하다
//Observable.range(start: 1, count: 9) // 스타트는 1부터 하여 9까지 카운트를 진행한다.
//    .subscribe(onNext: {
//        print("2*\($0)=\(2*$0)")
//    })

//
//print("--------dispose--------")
//Observable.of(1, 2, 3)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .dispose() // 구독취소
// 옵저버블를 정의(생성)를 하고  서브스크립트로 구독하면 디스포즈 시켜서 메모리 누수되는걸 작동시켜야한다.
// 이의 순서가 생명 주기이다.


//print("-------disposeBag--------")
//let disposeBag = DisposeBag()
//
//Observable.of(1, 2, 3)
//    .subscribe {
//        print($0)
//    }
//    .disposed(by: disposeBag) //디스포즈를 해야한다. 생명주기다. 메모리가 누수될수있기때문에


//print("--------create1--------")
//Observable.create { observer -> Disposable in
//    observer.onNext(1)
//    observer.onCompleted()
//    observer.onNext(2)
//    return Disposables.create()
//}
//.subscribe {
//    print($0)
//}
//.disposed(by: disposeBag)
//
//
//print("--------create2--------")
//enum MyError: Error {
//    case anError
//}
//
//Observable.create { observer -> Disposable in
//    observer.onNext(1)
//    observer.onError(MyError.anError)
//    observer.onCompleted()
//    observer.onNext(2)
//    return Disposables.create()
//}
//.subscribe(
//onNext: {
//    print($0)
//},
//onError: {
//    print($0.localizedDescription)
//},
//onDisposed: {
//    print("disposed")
//}
//)
//.disposed(by: disposeBag)
//
//
//print("--------defferd1--------")
//Observable.deferred {
//    Observable.of(1, 2, 3)
//}
//.subscribe {
//    print($0)
//}
//.disposed(by: disposeBag)
//
//print("--------defferd2--------")
//var 뒤집기: Bool = false
//
//let fatory: Observable<String> = Observable.deferred {
//    뒤집기 = !뒤집기
//
//    if 뒤집기 {
//        return Observable.of("이거다")
//    } else {
//        return Observable.of("다른거다")
//    }
//}
//
//for i in 0...3 {
//    fatory.subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//}
