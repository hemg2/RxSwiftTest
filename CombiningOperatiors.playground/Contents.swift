import UIKit
import RxSwift

let disposeBag = DisposeBag()

print("-----------startWith---------")

let λΈλλ° = Observable<String>.of("π§πΌ", "π§π»", "π¦π½")

λΈλλ°
    .enumerated()
    .map({ index, element in
            return element + "μ΄λ¦°μ΄" + "\(index)"
    })
    .startWith("π¨π»μ μλ")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----------concat1---------")

let λΈλλ°μ΄λ¦°μ΄λ€ = Observable<String>.of("π§πΌ", "π§π»", "π¦π½")
let μ μλ = Observable<String>.of("π¨π»μ μλ")

let μ€μμκ±·κΈ° = Observable
    .concat([μ μλ, λΈλλ°μ΄λ¦°μ΄λ€])

μ€μμκ±·κΈ°
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----------concat1-1---------")
μ μλ
    .concat(λΈλλ°μ΄λ¦°μ΄λ€)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----------concatMap---------")
let μ΄λ¦°μ΄μ§: [String: Observable<String>] = [
    "λΈλλ°": Observable.of("π§πΌ", "π§π»", "π¦π½"),
    "νλλ°": Observable.of("π§π»βπ§", "π©πΎβπ")
]
Observable.of("λΈλλ°", "νλλ°")
    .concatMap { λ° in
        μ΄λ¦°μ΄μ§[λ°] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----------merge1---------")

let κ°λΆ = Observable.from(["κ°λΆκ΅¬", "μ±λΆκ΅¬", "λλλ¬Έκ΅¬", "μ’λ‘κ΅¬"])
let κ°λ¨ = Observable.from(["κ°λ¨κ΅¬", "κ°λκ΅¬", "μλ±ν¬κ΅¬", "μμ²κ΅¬"])

Observable.of(κ°λΆ, κ°λ¨)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----------merge2---------")
Observable.of(κ°λΆ, κ°λ¨)
    .merge(maxConcurrent: 1)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----------combineLatest1---------")
let μ± = PublishSubject<String>()
let μ΄λ¦ = PublishSubject<String>()

let μ±λͺ = Observable
    .combineLatest(μ±, μ΄λ¦) { μ±, μ΄λ¦ in
        μ± + μ΄λ¦
    }

μ±λͺ
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

μ±.onNext("κΉ")
μ΄λ¦.onNext("λκ΅¬")
μ΄λ¦.onNext("μ±κ΅¬")
μ΄λ¦.onNext("μΌκ΅¬")
μ±.onNext("λ")
μ±.onNext("λ°")
μ±.onNext("μ΄")


print("-----------combineLatest2---------")
let λ μ§νμνμ = Observable<DateFormatter.Style>.of(.short, .long)
let νμ¬λ μ§ = Observable<Date>.of(Date())

let νμ¬λ μ§νμ = Observable.combineLatest(λ μ§νμνμ, νμ¬λ μ§,
resultSelector: {
    νμ, λ μ§ -> String in
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = νμ
    return dateFormatter.string(from: λ μ§)
})

νμ¬λ μ§νμ.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)




print("-----------combineLatest3---------")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable.combineLatest([firstName, lastName]) { name in
    name.joined(separator: " ")
    
}
fullName.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)
lastName.onNext("kim")
firstName.onNext("Paul")
firstName.onNext("Stella")
firstName.onNext("Lily")


print("-----------zip---------")
enum μΉν¨ {
    case μΉ
    case ν¨
}

let μΉλΆ = Observable<μΉν¨>.of(.μΉ, .μΉ, .ν¨, .μΉ, .ν¨)
let μ μ = Observable<String>.of("π°π·", "π¨π­", "πΊπΈ", "π§π·", "π―π΅", "π¨π³")
//λ¨Έμ§λ  2κ°μ λ°°μ΄μ΄ κ°κ° λ€λ₯΄λλΌλ λ€ λμ€μ§λ§ zipλ μλ‘ μλ λ©νΈκ° κ°μμΌμ§λ§ λνλλ€.
// κ·Έλμ λ§μ§λ§ μ€κ΅­μ μΉν¨κ°μλ€ λ§€μΉ­μ κ°μ΄ μκΈ°λλ¬Έμ
let μν©κ²°κ³Ό = Observable.zip(μΉλΆ, μ μ) { κ²°κ³Ό, λνμ μ in
    return λνμ μ + "μ μ" + " \(κ²°κ³Ό)!"
}
μν©κ²°κ³Ό
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)



print("----------withLatestFrom1----------")
let π₯π« = PublishSubject<Void>()
let λ¬λ¦¬κΈ°μ μ = PublishSubject<String>()

π₯π«.withLatestFrom(λ¬λ¦¬κΈ°μ μ)
//    .distinctUntilChanged()     //Sampleκ³Ό λκ°μ΄ μ°κ³  μΆμ λ
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

λ¬λ¦¬κΈ°μ μ.onNext("ππ»ββοΈ")
λ¬λ¦¬κΈ°μ μ.onNext("ππ»ββοΈ ππ½ββοΈ")
λ¬λ¦¬κΈ°μ μ.onNext("ππ»ββοΈ ππ½ββοΈ ππΏ")
π₯π«.onNext(Void())
π₯π«.onNext(Void())

print("----------sample----------")
let πμΆλ° = PublishSubject<Void>()
let F1μ μ = PublishSubject<String>()

F1μ μ.sample(πμΆλ°)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

F1μ μ.onNext("π")
F1μ μ.onNext("π   π")
F1μ μ.onNext("π      π   π")
πμΆλ°.onNext(Void())
πμΆλ°.onNext(Void())
πμΆλ°.onNext(Void())

print("----------amb----------")
let πλ²μ€1 = PublishSubject<String>()
let πλ²μ€2 = PublishSubject<String>()

let πλ²μ€μ λ₯μ₯ = πλ²μ€2.amb(πλ²μ€1)// λ¨Όμ  λμ¨κ²λ§ κ΅¬λνλ€

πλ²μ€μ λ₯μ₯.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

πλ²μ€2.onNext("λ²μ€2-μΉκ°0: π©πΎβπΌ") //λ²μ€ 2κ° λ¨Όμ  μ¨λ₯μ€νΈ νκΈ°λλ¬Έμ λ²μ€2λ§ λνλλ€
πλ²μ€1.onNext("λ²μ€1-μΉκ°0: π§πΌβπΌ")
πλ²μ€1.onNext("λ²μ€1-μΉκ°1: π¨π»βπΌ")
πλ²μ€2.onNext("λ²μ€2-μΉκ°1: π©π»βπΌ")
πλ²μ€1.onNext("λ²μ€1-μΉκ°1: π§π»βπΌ")
πλ²μ€2.onNext("λ²μ€2-μΉκ°2: π©πΌβπΌ")

print("----------switchLatest----------")
let π©π»βπ»νμ1 = PublishSubject<String>()
let π§π½βπ»νμ2 = PublishSubject<String>()
let π¨πΌβπ»νμ3 = PublishSubject<String>()

let μλ€κΈ° = PublishSubject<Observable<String>>()

let μλ μ¬λλ§λ§ν μμλκ΅μ€ = μλ€κΈ°.switchLatest()
μλ μ¬λλ§λ§ν μμλκ΅μ€
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

μλ€κΈ°.onNext(π©π»βπ»νμ1) // μ¨λ₯μ€νΈμ λ£μκ²λ§ κ΅¬λν¨
π©π»βπ»νμ1.onNext("π©π»βπ»νμ1: μ λ 1λ² νμμλλ€.")
π§π½βπ»νμ2.onNext("π§π½βπ»νμ2: μ μ μ μ!!!")

μλ€κΈ°.onNext(π§π½βπ»νμ2)// μ¨λ₯μ€νΈμ λ£μκ²λ§ κ΅¬λν¨
π§π½βπ»νμ2.onNext("π§π½βπ»νμ2: μ λ 2λ²μ΄μμ!")
π©π»βπ»νμ1.onNext("π©π»βπ»νμ1: μ.. λ μμ§ ν λ§ μλλ°")

μλ€κΈ°.onNext(π¨πΌβπ»νμ3)// μ¨λ₯μ€νΈμ λ£μκ²λ§ κ΅¬λν¨
π§π½βπ»νμ2.onNext("π§π½βπ»νμ2: μλ μ κΉλ§! λ΄κ°! ")
π©π»βπ»νμ1.onNext("π©π»βπ»νμ1: μΈμ  λ§ν  μ μμ£ ")
π¨πΌβπ»νμ3.onNext("π¨πΌβπ»νμ3: μ λ 3λ² μλλ€~ μλ¬΄λλ μ κ° μ΄κΈ΄ κ² κ°λ€μ.")

μλ€κΈ°.onNext(π©π»βπ»νμ1)// μ¨λ₯μ€νΈμ λ£μκ²λ§ κ΅¬λν¨
π©π»βπ»νμ1.onNext("π©π»βπ»νμ1: μλ, νλ Έμ΄. μΉμλ λμΌ.")
π§π½βπ»νμ2.onNext("π§π½βπ»νμ2: γ γ ")
π¨πΌβπ»νμ3.onNext("π¨πΌβπ»νμ3: μ΄κΈ΄ μ€ μμλλ°")
π§π½βπ»νμ2.onNext("π§π½βπ»νμ2: μ΄κ±° μ΄κΈ°κ³  μ§λ μλ€κΈ°μλμ?")


print("----------reduce----------")
Observable.from((1...10)) // μλ¦¬λ¨ΌνΈλ€ λνκΈ°νκΈ° λν΄μ§ νκΊΌλ²μ κ°μ λ³΄μ¬μ€
    .reduce(0, accumulator: { summary, newValue in
        return summary + newValue
    })
//    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----------scan----------")
Observable.from((1...10)) // μλ¦¬λ¨ΌνΈλ€ λνκΈ°λ κ³Όμ μ λ³΄μ¬μ€
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
