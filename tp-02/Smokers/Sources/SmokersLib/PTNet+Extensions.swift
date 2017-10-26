import PetriKit

public class MarkingGraph {

    public let marking   : PTMarking
    public var successors: [PTTransition: MarkingGraph]

    public init(marking: PTMarking, successors: [PTTransition: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors
    }

}

public extension PTNet {

    public func markingGraph(from marking: PTMarking) -> MarkingGraph? {
       // Write here the implementation of the marking graph generation
       let T = self.transitions //ensembles de transitions du modèle
       let mk = MarkingGraph(marking: marking) //marking Graph a retourner (initialisé)
       var reste = [mk] //marquage non-traités restants
       var M = [MarkingGraph]() //marquages traités
       while let noeud_courent = reste.popLast(){  //on continue tant qu'il y a des marquages a traiter
         M.append(noeud_courent)                  // on place le marquage comme deja traité
         for i in T {     //on itere sur i toutes les transitions du modèle
           //si le marquage est tirable, on verifie s'il est dans reste et dans M si oui on tire les successeurs (on évite les doublons)
           if i.fire(from: noeud_courent.marking) != nil{
             let m0 = i.fire(from: noeud_courent.marking)
             if reste.contains(where: {$0.marking == m0!}) {
               noeud_courent.successors[i] = reste.first(where: {$0.marking == m0!})
             }
             else if M.contains(where: {$0.marking == m0!}) {
               noeud_courent.successors[i] = M.first(where: {$0.marking == m0!})
             }
             else {               // sinon, on les met dans reste pour les traiter
               let newMK = MarkingGraph(marking : m0!)
               noeud_courent.successors[i] = newMK
               reste.append(newMK)
             }
           }
         }
       }
       return mk
     }
   }
