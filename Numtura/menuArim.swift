import SwiftUI
//Clase para los puntos de la misiones
class objetos{
    var nameFile:String
    var w:CGFloat
    var h:CGFloat
    var p:CGFloat
    init(nameFile: String, w: CGFloat, h: CGFloat, p:CGFloat) {
        self.nameFile = nameFile
        self.w = w
        self.h = h
        self.p = p
    }
}
//Clase de mision
class misionObject{
    var textTittle:String
    var coordenadas:String
    var objeto:objetos
    var page:String
    init(textTittle: String, coordenadas: String, objeto: objetos, page: String) {
        self.textTittle = textTittle
        self.coordenadas = coordenadas
        self.objeto = objeto
        self.page=page
    }
    
}
struct menuArim: View {
    
    @State private var rotation: Double = 0
    @State private var currentIndex: Int = 0

    
    //objetos de las misiones
    var estacionDajo=objetos(nameFile: "arimObj1", w: 130, h: 130,p:0)
    var observatorio=objetos(nameFile: "observatory_3594152", w: 130, h: 130,p:130)
    var base = objetos(nameFile: "base", w: 230, h: 230,p:130)
    let colorBorder:LinearGradient = LinearGradient(colors: [.planet3C2,.planet3C1, .planet3C2,], startPoint: .top, endPoint: .bottom)
    
    //misiones
    var m1: misionObject!
    var m2: misionObject!
    var m3: misionObject!
    var misionesList:[misionObject]!
    init() {
        m1 = misionObject(textTittle: "ESTACIÓN DAJO", coordenadas: "(51° 30' 30'' N; 0° 7' 32'' O)", objeto: estacionDajo, page: "")
        m2 = misionObject(textTittle: "TELESCOPIO FERA", coordenadas: "(32° 23' 40'' N; 0° 2' 22'' 1)", objeto: observatorio, page: "")
        m3 = misionObject(textTittle: "ESTACIÓN RAMACO", coordenadas: "(25° 22' 52'' N; 2° 5' 25'' 5)", objeto: base, page: "")
        
        misionesList = [m1, m2, m3]
    }
    var body: some View {
        
        ZStack {
            BackgroundView()
            
            ZStack {
                VStack{
                    cardInfo(mision: misionesList [currentIndex]).padding(.bottom, 800)
                }
                placeView(objeto:misionesList[currentIndex].objeto)
                VStack{
                    ZStack{
                            Image("planet01")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 1100, height: 1100)
                                .rotationEffect(Angle.degrees(90), anchor: .center)
                                .animation(.interactiveSpring(duration: 0.1))
                            Circle()
                                .stroke(colorBorder, lineWidth: 13)
                                .frame(width: 1080, height: 1100)
                                .shadow(color: .planet3C2, radius: 16, x: 0, y: 0)
                        /*mage(estacionDajo.nameFile)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 130)
                                .padding(.bottom, 1440)*/
                        
                    }.rotationEffect(Angle.degrees(rotation))
                        .padding(.bottom, -1000)
                        .gesture(
                            DragGesture(minimumDistance: 5, coordinateSpace: .local)
                                .onEnded { value in
                                    withAnimation {
                                        rotation += value.translation.width > 0 ? 120 : -120
                                        updateCurrentMission()
                                    }
                                }
                        )
                }.padding(.top,500)
            }
            
            Test()
                .padding(.top, 1000)
        }
    }
    // Función para actualizar el índice actual de la misión en función de la rotación
    private func updateCurrentMission() {
        let totalMissions = misionesList.count
        let missionAngle = 360.0 / Double(totalMissions)
        let direction: Double = rotation > 0 ? 1 : -1
        let normalizedRotation = (rotation * direction + 360).truncatingRemainder(dividingBy: 360)
        let newIndex = Int(normalizedRotation / missionAngle)
        currentIndex = newIndex
        rotation = Double(newIndex) * missionAngle * direction
    }
}
struct cardInfo:View{
   // var coordenadas:String
    //var titulo:String
    var mision: misionObject
    let gradient: LinearGradient = LinearGradient(colors: [.black, .planet3C2,], startPoint: .top, endPoint: .bottom)
    let colorBorder:LinearGradient = LinearGradient(colors: [.planet3C2,.planet3C1, .planet3C2,], startPoint: .top, endPoint: .bottom)
    let border:CGFloat=60.0
    func holaMundo(){
        print("Hola mundo")
    }
    var body: some View{
        ZStack{
            Rectangle()
                .fill(gradient.opacity(0.7))
                .blur(radius: 7)
                .frame(width: 700, height: 340)
                .cornerRadius(border)
                .overlay(
                    RoundedRectangle(cornerRadius: border)
                        .stroke(colorBorder, lineWidth: 4) // Cambia el color y el ancho del borde según tus preferencias
                )
            Rectangle()
                .fill(Color.black.opacity(0.6))
                .frame(width: 700, height: 340)
                .cornerRadius(border)
               
            VStack{
                Text(mision.coordenadas)
                    .font(.custom("Montserrat", size: 20))
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 5, x: 0, y: 0)
                    .padding(.top, 25)
                
                Text(mision.textTittle)
                    .font(.custom("Montserrat", size: 50))
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 5, x: 0, y: 0)
                    .padding(.top, 10)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 300, height: 2)
                
                Button(action: holaMundo, label: {
                    Text("INICIAR")
                        .font(.custom("Montserrat", size: 20))
                        .foregroundColor(.black)
                        .padding(.trailing, 40)
                        .padding(.leading, 40)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(40)
                }).padding(.top, 30)
            }
            
                
        }
    }
}
struct placeView:View{
    let objeto:objetos
    var body: some View{
        ZStack{
            Image(objeto.nameFile).resizable().frame(width: objeto.w, height: objeto.h).padding(.top,objeto.p)
        }.frame(width: 300,height: 400).padding(.bottom,-160)
    }
}
struct menuArim_Previews: PreviewProvider {
    static var previews: some View {
        menuArim()
    }
}
