import PetriKit

class MarkingGraph {
  let marking : PTMarking
  var successors : [ MarkingGraph ]

init ( marking : PTMarking , successors : [ MarkingGraph ] ) {
  self.marking = marking
  self.successors = successors
  }
}

var m0 = MarkingGraph(marking: ["p1", "p2", "p3", "f1", "f2", "f3"], successors:[])
var m1 = MarkingGraph(marking: [])
