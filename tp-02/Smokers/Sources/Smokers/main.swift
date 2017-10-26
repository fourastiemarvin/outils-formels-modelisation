import PetriKit
import SmokersLib

// Instantiate the model.
let model = createModel()

// Retrieve places model.
guard let r  = model.places.first(where: { $0.name == "r" }),
      let p  = model.places.first(where: { $0.name == "p" }),
      let t  = model.places.first(where: { $0.name == "t" }),
      let m  = model.places.first(where: { $0.name == "m" }),
      let w1 = model.places.first(where: { $0.name == "w1" }),
      let s1 = model.places.first(where: { $0.name == "s1" }),
      let w2 = model.places.first(where: { $0.name == "w2" }),
      let s2 = model.places.first(where: { $0.name == "s2" }),
      let w3 = model.places.first(where: { $0.name == "w3" }),
      let s3 = model.places.first(where: { $0.name == "s3" })
else {
    fatalError("invalid model")
}

// Create the initial marking.
let initialMarking: PTMarking = [r: 1, p: 0, t: 0, m: 0, w1: 1, s1: 0, w2: 1, s2: 0, w3: 1, s3: 0]
// fonction qui parcourt le marking graph
func countNodes(markingGraph: MarkingGraph) -> Int{
  var seen = [markingGraph]
  var toVisit = [markingGraph]
  while let current = toVisit.popLast(){
    for (_,successor) in current.successors{
      if !seen.contains(where: {$0 === successor}) {
        seen.append(successor)
        toVisit.append(successor)
      }
    }
  }
  return seen.count
}

//fonction qui parcourt le marking graph et qui retourne s'il peut y avoir deux fumeurs qui fument en même temps
func istwosmokers(markingGraph : MarkingGraph) -> Bool{
  var seen = [markingGraph]
  var toVisit = [markingGraph]
  while let current = toVisit.popLast(){
    for (_,successor) in current.successors{
      if !seen.contains(where: {$0 === successor}) {
        seen.append(successor)
        toVisit.append(successor)
        if (successor.marking[s1] == 1 && successor.marking[s2] == 1){
          return true
      }
      }
    }
  }
  return false
}

//fonction qui parcourt le marking graph et qui retourne si l'état ou il y a deux ingrediants est présent dans le graphe
func istwoingredients(markingGraph : MarkingGraph) -> Bool{
  var seen = [markingGraph]
  var toVisit = [markingGraph]
  while let current = toVisit.popLast(){
    for (_,successor) in current.successors{
      if !seen.contains(where: {$0 === successor}) {
        seen.append(successor)
        toVisit.append(successor)
        if successor.marking[p] == 2 || successor.marking[m] == 2 || successor.marking[t] == 2{
          return true
        }
      }
    }
  }
  return false
}

// Create the marking graph (if possible).
if let markingGraph = model.markingGraph(from: initialMarking) {
    // Write here the code necessary to answer questions of Exercise 4.
print("nombre de noeuds:")
print(countNodes(markingGraph : markingGraph))
print("il y a deux fumeurs?")
print(istwosmokers(markingGraph : markingGraph))
print("il y a deux mêmes ingrediant sur la table?")
print(istwoingredients(markingGraph : markingGraph))

}
//1) Il y a 32 états differents possible
//2) 2 fumeurs peuvent fumer en même temps
//3) il ne peut pas y avoir deux fois le même ingrediant sur la table
