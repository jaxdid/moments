class ConstraintAdder {
  func run(snapshotView: UIView, width: Int, height: Int) {
    let views = ["snapshotView": snapshotView]
    snapshotView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[snapshotView(\(width))]", options: [], metrics: nil, views: views))
    snapshotView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[snapshotView(\(height))]", options: [], metrics: nil, views: views))
  }
}
