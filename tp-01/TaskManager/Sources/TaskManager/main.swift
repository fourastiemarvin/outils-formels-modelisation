import TaskManagerLib


//réseau de Petri de base
let taskManager = createTaskManager()
//on importe les places
let taskPool    = taskManager.places.first { $0.name == "taskPool" }!
let processPool = taskManager.places.first { $0.name == "processPool" }!
let inProgress  = taskManager.places.first { $0.name == "inProgress" }!
//on importe les transitions
let create   = taskManager.transitions.first { $0.name == "create" }!
let spawn      = taskManager.transitions.first { $0.name == "spawn" }!
let exec        = taskManager.transitions.first { $0.name == "exec" }!
let success     = taskManager.transitions.first { $0.name == "success" }!
let fail        = taskManager.transitions.first { $0.name == "fail" }!

//on tire les transitions un par un avec le marquage de départ
    let mq1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])
    let mq2 = spawn.fire(from: mq1!)
    print(mq1!)
    print("on place un jeton dans taskPool et processPool:")
    let mq3 = spawn.fire(from: mq2!)
    print("on met un deuxième jeton dans le processPool")
    print(mq2!)
    let mq4 = exec.fire(from: mq3!)
    print("on execute alors 2 fois")
    print(mq3!)
    let mq5 = exec.fire(from: mq4!)
    print(mq4!)
    let mq6 = success.fire(from: mq5!)
    print("on est donc bloqué et on a 1 processus en cours")
    print(mq5!)
    print(mq6!)

//réseau de Petri modifié
let correctTaskManager = createCorrectTaskManager()
//on importe les places
let MtaskPool    = taskManager.places.first { $0.name == "taskPool" }!
let MprocessPool = taskManager.places.first { $0.name == "processPool" }!
let MinProgress  = taskManager.places.first { $0.name == "inProgress" }!
//on a crée la place endprocess qui servira à indiquer si le processus en cours a terminé
let endprocess = taskManager.places.first { $0.name == "endprocess"}!
//on importe les transitions
let Mcreate   = taskManager.transitions.first { $0.name == "create" }!
let Mspawn      = taskManager.transitions.first { $0.name == "spawn" }!
let Mexec        = taskManager.transitions.first { $0.name == "exec" }!
let Msuccess     = taskManager.transitions.first { $0.name == "success" }!
let Mfail        = taskManager.transitions.first { $0.name == "fail" }!

//on tire les transitions un par un avec le marquage de départ
// on doit mettre un jeton dans la place créée pour pouvoir executer
//dans l'execution suivante on a une condition non tirable au moment du 2e exec car la tache inProgress n'est pas encore finie
    let mm1 = create.fire(from: [MtaskPool: 0, MprocessPool: 0, MinProgress: 0, endprocess: 1])
    let mm2 = spawn.fire(from: mm1!)
    let mm3 = spawn.fire(from: mm2!)
    let mm4 = exec.fire(from: mm3!)
    let mm5 = exec.fire(from: mm4!)
    let mm6 = success.fire(from: mm5!)
