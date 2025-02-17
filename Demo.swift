import SwiftUI


struct ContentTransitionDemo: View {
    @State private var showUpdate = true

    var body: some View {
        VStack(spacing: 20) {

            Text(showUpdate ? "256" : "462")
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .padding()
                .bold()
                .contentTransition(.numericText(countsDown: false))

            Button {
                withAnimation(.spring(.bouncy)) {
                    showGreeting.toggle()
                }
            } label: {
                Text(showUpdate ? "Update" :"Updated")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.black)
                    .contentTransition(.numericText(countsDown: false))
            }
        }
        .padding()
    }
}


struct NumericTextTransitionView: View {
    @State private var number: Double = 0
    @State private var isLimit : Bool = false
    @State private var offsetX : CGFloat = 0
  
    var body: some View {
        
        HStack(spacing: 20) {
            Button {
                if number > 0 {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        number -= 1
                    }
                } else {
                    withAnimation(.spring()){
                        isLimit = true
                    }
                    wiggle()
                }
            } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                }
    
            Text("\(number, specifier: "%.0f")")
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .contentTransition(.numericText(value: number))
                .frame(width:160)
                .offset(x:offsetX)
            
            Button {
                withAnimation(.easeInOut(duration: 0.5)) {
                    number += 1
                }
                
                isLimit = false
            } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                }
            }
        .padding()
    }

  //simple wiggle function
    private func wiggle() {
    
        let intensity : CGFloat = 10
    
        withAnimation(.easeInOut(duration: 0.1)){
            self.offsetX = -intensity
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 0.1)){
                self.offsetX = intensity
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.spring(.bouncy)){
                self.offsetX = 0
            }
        }

    }
}


struct ButtonExample: View {
    @State private var isPressed = false
    var body: some View {
        ZStack{
            Text(isPressed ? "Following" : "Follow")
                .font(.system(size: 24, design: .rounded))
                .foregroundStyle(isPressed ? .black.opacity(0.8) : .white)
                .bold()
                .contentTransition(.numericText())
            
                
        }
        .frame(width:160)
        .padding()
        .background(isPressed ? .white : .black)
        .cornerRadius(24)
        .onTapGesture {
            withAnimation(.spring()){
                isPressed.toggle()
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(isPressed ? .black.opacity(0.8) : .black, lineWidth: isPressed ? 4 : 4)
        )
    }
}


struct Examples : View {
    var body: some View {
        Spacer()
        ButtonExample()
        Spacer()
        NumericTextTransitionView()
        Spacer()
        ContentTransitionDemo()
        Spacer()
    }
}


#Preview("ContentTransition"){
    Examples()
}
