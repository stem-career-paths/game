extends SceneTree

const DistributionCalculator := preload("res://tools/balance/distribution_calculator.gd")

var _distribution := DistributionCalculator.new()


func _run():
	var args := _get_args()

	if not args.is_empty():
		print("Running on specific stories is not supported yet.")
		return

	var distribution := _distribution.calculate()

	print("Total attributes from all options from all stories:")
	print(distribution)


func _get_args() -> PackedStringArray:
	var args := OS.get_cmdline_args()

	while args.size() > 0:
		var arg := args[0]
		args.remove_at(0)

		if arg.contains("cmdln.gd"):
			break

	return args


func _init():
	_run()
	quit()
