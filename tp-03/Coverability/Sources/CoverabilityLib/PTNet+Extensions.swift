import PetriKit

public extension PTNet {

  public func CovMarktoPT (from marking: CoverabilityMarking) -> PTMarking {
    //fonction qui convertit un graphe de couverture en graphe de marquage (pour pouvoir tirer les conditions)
      var mk : PTMarking = [:]
      let place_min : Int = 0
      for k in self.places{
        mk[k] = 10
        for i in place_min...mk.count{
          if UInt(i) == marking[k]!{
            mk[k] = UInt(i)
          }
        }
      }
      return mk
}

public func PTtoCovMark (from marking: PTMarking) -> CoverabilityMarking {
  //fonction qui convertit un graphe de marquage en graphe de couverture (pour retourner le bon type)
     var mk : CoverabilityMarking = [:]
     for i in self.places{
       if marking[i]!<=10{
         mk[i] = .some(marking[i]!)
       }
       else{
         mk[i] = .omega
       }
     }
     return mk
}

    public func coverabilityGraph(from marking: CoverabilityMarking) -> CoverabilityGraph {
        let T = self.transitions
        let mk = CoverabilityGraph(marking: marking)
        var reste = [mk]
        var M = [CoverabilityGraph]()
        while let noeud_courent = reste.popLast(){
          M.append(noeud_courent)
          for i in T {
            if i.fire(from: CovMarktoPT(from: noeud_courent.marking)) != nil{
              let m0 = i.fire(from: CovMarktoPT(from: noeud_courent.marking))
              var m1 = PTtoCovMark(from: m0!)
              for old in mk{
                    if m1 > old.marking{
                      for k in self.places{
                        if m1[k]! > old.marking[k]!{
                            m1[k] = .omega
                        }
                      }
                    }
                  }
              if reste.contains(where: {$0.marking == m1}) {
                noeud_courent.successors[i] = reste.first(where: {$0.marking == m1})
              }
              else if M.contains(where: {$0.marking == m1}) {
                noeud_courent.successors[i] = M.first(where: {$0.marking == m1})
              }
              else {
                let newMK = CoverabilityGraph(marking : m1)
                noeud_courent.successors[i] = newMK
                reste.append(newMK)
              }
            }
          }
        }
        return mk
        }
    }
