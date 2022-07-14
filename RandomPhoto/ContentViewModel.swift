import CoreImage

class ContentViewModel: ObservableObject {
  private var isFirstLaunch = !isAppAlreadyLaunchedOnce()
  @Published var isGuideDone = true
  
    
  init() {
    if(isFirstLaunch) {
        isGuideDone = false
    }
    
  }

}
