import UIKit

/*
 1. ARC란?
 ARC(Automatic Reference Counting) : 자동으로 메모리를 관리해주는 방식
 참조 타입은 하나의 인스턴스가 참조를 통해 여러 곳에서 접근하기 때문에 언제 메모리에서 해제되는지가 중요한 문제
 메모리 자원을 낭비하면 성능의 저하로 이어지기 때문에 적절한 메모리 사용을 위해 ARC 사용
 더이상 필요하지 않은 클래스의 인스턴스를 메모리에서 해제하는 방식으로 동작
 
 ARC vs GarbageCollection
 참조를 계산하는 시점의 차지 (ARC는 컴파일과 동시에 결정, 가비지 컬렉션은 프로그램 동작 중 결정)
 ARC의 장점 - 컴파일 당시 이미 인스턴스의 해제 시점이 정해져 있어서 인스턴스가 언제 메모리에서 해제될지 예측 가능, 시스템 자원을 추가할 필요가 없음.
 ARC의 단점 - 작동 규칙을 모르고 사용하면 인스턴스가 메모리에서 영원히 해제되지 않을 가능성 있음.
*/

/*
 2. 강한참조 (Strong Reference)
 인스턴스가 계속해서 메모리에 남아있어야 하는 명분을 만들어 주는 것
 인스턴스는 참조 횟수가 0이 되는 순간 메모리에서 해제되는데, 강한참조를 사용하면 참조 횟수가 1 증가함.
 강한참조를 사용하는 프로퍼티, 변수, 상수 등에 nil을 할당해주면 참조 횟수가 1 감소함. (이를 이용해 참조 횟수를 0으로 만들어 의도적으로 해제하는 것이 가능 - 해제되기 직전에 deinitializer 호출)
 참조의 기본은 강한참조이므로 별도의 식별자를 명시하지 않으면 강한참조를 하게 됨. (지금까지 써왔던 대부분의 프로퍼티들이 강한참조였던 것)
 
 강한참조 순환(Strong Reference Cycle) 문제
 인스턴스끼리 서로가 서로를 강한참조할 때 강한참조 순환문제가 발생함.
 nil을 할당하면 참조 횟수가 1 감소하는걸 이용해서 해결할 수는 있지만 다른 방법을 더 선호.
 
 인스턴스가 메모리에서 해제될 때, 자신의 프로퍼티가 강한참조를 하던 인스턴스의 참조 횟수를 1 감소시킴.
*/

/*
 3. 약한참조 (Weak Reference)
 강한 참조와는 달리 자신이 참조하는 인스턴스의 참조 횟수를 증가시키지 않음.
 weak 키워드를 프로퍼티나 변수의 선언 앞에 써주면 자신이 참조하는 인스턴스를 약한참조함.
 자신이 참조하던 인스턴스가 메모리에서 해제된다면 nil이 해당될 수 있어야 하기 때문에 상수에는 쓸 수 없음. 또한 nil이 할당될 수 있어야하기 때문에 항상 옵셔널이어야 함.
 자신이 참조하는 인스턴스가 메모리에서 해제되면 자동으로 nil을 할당
*/

/*
 4. 미소유참조 (Unowned Reference)
 자신이 참조하는 인스턴스가 항상 메모리에 존재할 것이라는 전제를 기반으로 동작함. (자신이 참조하는 인스턴스가 메모리에서 해제되더라도 스스로 nil을 할당해주지 않는다는 뜻 - 옵셔널이나 변수가 아니어도 된다는 의미)
 참조하는 동안 해당 인스턴스가 메모리에서 해제되지 않으리라는 확신이 있을 때만 사용해야 함. (메모리에서 해제된 인스턴스에 접근하려고 하면 에러가 발생하고 강제 종료되기 때문)
 참조 타입의 변수나 프로퍼티의 정의 앞에 unowned 키워드를 써주면 됨.
 가질 수도, 가지지 않을 수도 있는 쪽은 옵셔널로 정의, 강한참조해야 함. 반대쪽은 미소유참조 사용.
*/

/*
 5. 미소유 옵셔널 참조
*/