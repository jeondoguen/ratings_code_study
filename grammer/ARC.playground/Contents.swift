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
 클래스를 참조하는 옵셔널을 미소유로 표시할 수 있음.
 미소유참조 중 옵셔널이 될 수 있는 것. 이 경우 항상 인스턴스를 참조할 수 있도록 신경써야 됨.
 
 옵셔널은 값 타입일지라도 예외적으로 unowned 등을 활용해 참조 관리를 할 수 있음.
 또한, 클래스를 감싸는 옵셔널은 참조 횟수 계산을 하지 않기 때문에 강한 참조로 관리할 필요도 없음.
*/


/*
 6. 미소유참조와 암시적 추출 옵셔널 프로퍼티
 서로 참조해야 하는 프로퍼티에 값이 꼭 있어야 하면서 한번 초기화되면 그 이후에는 nil을 할당할 수 없는 조건의 경우,
 옵셔널이 될 수 없는 부분은 미소유참조로, 자기 자신을 참조하도록 해줘야 되는 부분은 암시적 추출 옵셔널을 사용.
 암시적 추출 옵셔널 프로퍼티는 2단계 초기화 조건 충족(1단계 초기화 완료 전까지는 인스턴스 프로퍼티의 값을 읽어들일 수 없음)을 충족시키기 위해 사용.
 미소유참조는 약한참조를 사용할 수 없는 경우(옵셔널이 아니거나 상수로 지정해야 하는 경우)에 강한참조를 피하기 위해 사용
*/

/*
 7. 클로저의 강한참조 순환
 강한참조 순환 문제는 클로저가 인스턴스의 프로퍼티일 때나, 클로저의 값 획득 특성 때문에도 발생.
 클로저 내 self를 획득하는 과정에서 강한참조 순환 발생. (이는 클로저가 클래스와 같은 참조 타입이기 때문)
 클로저의 획득 목록을 통해 해결 가능.
 클로저는 자신이 호출되면 언제든지 자신 내부의 참조들을 사용할 수 있도록 참조 횟수를 증가시켜 메모리에서 해제되는 것을 방지하는데, 이때 자신을 프로퍼티로 갖는 인스턴스의 참조 횟수도 증가시킴.
 클로저 내부에서 self 프로퍼티를 여러 번 호출하여 접근한다고 해도 참조 횟수는 한 번만 증가.
 
 획득목록 (Capture list)
 획득목록은 클로저 내부에서 참조 타입을 획득하는 규칙을 제시할 수 있는 기능.
 클로저 내부의 self 참조를 약한참조, 강한참조로 지정하는 것이 가능.
 클로저 내부의 매개변수 목록 이전 위치에 작성.
 참조 방식과 참조할 대상을 []로 둘러싼 목록 형식으로 작성하며 획득목록 뒤에는 in 키워드를 써줌. 획득목록에 명시한 요소가 참조 타입이 아닐 땐 클로저가 생성될 때 해당 요소들은 초기화됨.
 획득목록에서 약한획득을 하게 되면 획득하는 상수가 옵셔널 상수로 지정된다는 것에 주의해야 함. (이는 차후에 클로저 내부에서 상수를 사용하려고 할 때 이미 메모리에서 해제된 상태일 수 있기 때문)
*/
