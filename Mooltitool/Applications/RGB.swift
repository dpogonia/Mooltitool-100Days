import SwiftUI

struct RGBView: View {
    // @State отслеживает изменения в свойстве и реагирует на изменение во View, соответственно меняя View
    @State var redComponent: Double = 0.5
    @State var greenComponent: Double = 0.5
    @State var blueComponent: Double = 0.5
    
    var body: some View {
        VStack {
            // .colorMultiply применяет тот или иной цвет к ползунку Slider
            Slider(value: $redComponent).colorMultiply(.red)
            Text("Red: \(Int(redComponent * 255))")
            // знак $ означает использование связанного значения. Связывание значений позволяет связать значение переменной с представлением, таким образом, что изменение значения переменной автоматически обновляет представление, и наоборот.
            Slider(value: $greenComponent).colorMultiply(.green)
            Text("Green: \(Int(greenComponent * 255))")
            
            Slider(value: $blueComponent).colorMultiply(.blue)
            Text("Blue: \(Int(blueComponent * 255))")
            // Эта строка создает представление Color, которое отображает цвет, определенный значениями компонентов RGB. В данном коде, созданный цвет используется для отображения прямоугольника с этим цветом в пользовательском интерфейсе.
            Color(red: redComponent, green: greenComponent, blue: blueComponent)
            
            HStack {
                Text("Hex: \(hexCode)")
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(10)
                Button(action: {
                    //UIPasteboard копирует значение переменной в буфер обмена
                    UIPasteboard.general.string = hexCode}) {
                        Text("Копировать")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                        .cornerRadius(10)}}
            .padding(.all, 10.0)
            // Используется для вызова функции до появления View. Используется для вызова функции updateHexCode() при появлении представления RGBView на экране. Это позволяет обновить значение переменной hexCode и отобразить актуальный шестнадцатеричный код цвета.
            .onAppear {
                updateHexCode() }
            // Используется для реагирования на изменение значения определенного свойства и выполнения определенного действия в ответ на это изменение. Когда одно из этих свойств изменяется, соответствующая функция updateHexCode() вызывается для обновления значения переменной hexCode.
            .onChange(of: redComponent, perform: { _ in
                updateHexCode() } )
            .onChange(of: greenComponent, perform: { _ in
                updateHexCode() } )
            .onChange(of: blueComponent, perform: { _ in
                updateHexCode() } )
        }.background(Color.teal)
    }
    
    private func updateHexCode() {
        let hexCode = String(format: "#%02X%02X%02X", Int(redComponent * 255), Int(greenComponent * 255), Int(blueComponent * 255))
        self.hexCode = hexCode }
    @State private var hexCode: String = ""
}
