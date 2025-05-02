import Foundation
import AppKit

class Movement {
    private var timer: Timer?
    private var animationTimer: Timer?

    func startMoving() {
        scheduleNextMovement()
    }

    func stopMoving() {
        timer?.invalidate()
        animationTimer?.invalidate()
        timer = nil
        animationTimer = nil
    }

    private func scheduleNextMovement() {
        guard let screenFrame = NSScreen.main?.visibleFrame else { return }
        let randomX = CGFloat.random(in: screenFrame.minX...screenFrame.maxX)
        let randomY = CGFloat.random(in: screenFrame.minY...screenFrame.maxY)
        let targetPoint = CGPoint(x: randomX, y: randomY)

        // Choose random durations
        let moveDuration = TimeInterval.random(in: 1...3)
        let pauseDuration = TimeInterval.random(in: 10...15)

        let startPoint = NSEvent.mouseLocation
        animateMovement(from: startPoint, to: targetPoint, duration: moveDuration) { [weak self] in
            guard let self = self else { return }
            self.timer = Timer.scheduledTimer(withTimeInterval: pauseDuration, repeats: false) { _ in
                self.scheduleNextMovement()
            }
        }
    }

    private func animateMovement(from start: CGPoint, to target: CGPoint, duration: TimeInterval, completion: @escaping () -> Void) {
        let dx = target.x - start.x
        let dy = target.y - start.y
        let frames = max(1, Int(duration * 60))
        let interval = duration / Double(frames)
        var frameCount = 0

        animationTimer?.invalidate()
        animationTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            if frameCount >= frames {
                timer.invalidate()
                completion()
                return
            }
            let progress = Double(frameCount) / Double(frames)
            let x = start.x + CGFloat(progress) * dx
            let y = start.y + CGFloat(progress) * dy
            CGWarpMouseCursorPosition(CGPoint(x: x, y: y))
            frameCount += 1
        }
    }
}
