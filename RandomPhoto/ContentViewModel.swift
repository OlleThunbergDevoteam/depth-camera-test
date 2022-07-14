import CoreImage

class ContentViewModel: ObservableObject {
  private var isFirstLaunch = !isAppAlreadyLaunchedOnce()
  @Published var isGuideDone = true
  
    
  init() {
      print("Initialize ContentViewModel")
    if(isFirstLaunch) {
        isGuideDone = false
    }
    
  }

}
