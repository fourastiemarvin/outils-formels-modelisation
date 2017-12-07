import ProofKitLib

let a: Formula = "a"
let b: Formula = "b"
let c: Formula = "c"
let d: Formula = "d"

let e = (a || (c && d))
let f = (!d) || ((a && c) && (c || d))
let g = (a || b) => (a && b)
let h = (a || d) => (c || !(b => d))

print("Quelques exemples:")
print("DNF de \(e) : \(e.dnf) ")
print("CNF de \(e) : \(e.cnf)\n")

print("DNF de \(f) : \(f.dnf) ")
print("CNF de \(f) : \(f.cnf)\n")

print("DNF de \(g) : \(g.dnf) ")
print("CNF de \(g) : \(g.cnf)\n")

print("DNF de \(h) : \(h.dnf) ")
print("CNF de \(h) : \(h.cnf)")


/*
let booleanEvaluation = f.eval { (proposition) -> Bool in
    switch proposition {
        case "p": return true
        case "q": return false
        default : return false
    }
}
print(booleanEvaluation)

enum Fruit: BooleanAlgebra {

    case apple, orange

    static prefix func !(operand: Fruit) -> Fruit {
        switch operand {
        case .apple : return .orange
        case .orange: return .apple
        }
    }

    static func ||(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.orange, .orange): return .orange
        case (_ , _)           : return .apple
        }
    }

    static func &&(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.apple , .apple): return .apple
        case (_, _)           : return .orange
        }
    }

}

let fruityEvaluation = f.eval { (proposition) -> Fruit in
    switch proposition {
        case "p": return .apple
        case "q": return .orange
        default : return .orange
    }
}
print(fruityEvaluation)
*/
