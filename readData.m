function [train, test] = readData()

testStr = {"data/corel5k_test_Hsv.hvecs32",
		"data/corel5k_test_HsvV3H1.hvecs32",
		"data/corel5k_test_Lab.hvecs32", 
		"data/corel5k_test_LabV3H1.hvecs32",
		"data/corel5k_test_Rgb.hvecs32",
		"data/corel5k_test_RgbV3H1.hvecs32",

		"data/corel5k_test_Gist.fvec",

		"data/corel5k_test_DenseHue.hvecs", 
		"data/corel5k_test_DenseHueV3H1.hvecs", 
		"data/corel5k_test_DenseSift.hvecs",
		"data/corel5k_test_DenseSiftV3H1.hvecs",
		"data/corel5k_test_HarrisHue.hvecs",
		"data/corel5k_test_HarrisHueV3H1.hvecs",
		"data/corel5k_test_HarrisSift.hvecs",
		"data/corel5k_test_HarrisSiftV3H1.hvecs",
		"data/corel5k_test_annot.hvecs"};

trainStr = {"data/corel5k_train_Hsv.hvecs32",
	"data/corel5k_train_HsvV3H1.hvecs32",
	"data/corel5k_train_Lab.hvecs32",
	"data/corel5k_train_LabV3H1.hvecs32",
	"data/corel5k_train_Rgb.hvecs32",
	"data/corel5k_train_RgbV3H1.hvecs32",

	"data/corel5k_train_Gist.fvec",

	"data/corel5k_train_DenseHue.hvecs",
	"data/corel5k_train_DenseHueV3H1.hvecs",
	"data/corel5k_train_DenseSift.hvecs",
	"data/corel5k_train_DenseSiftV3H1.hvecs",
	"data/corel5k_train_HarrisHue.hvecs",
	"data/corel5k_train_HarrisHueV3H1.hvecs",
	"data/corel5k_train_HarrisSift.hvecs",
	"data/corel5k_train_HarrisSiftV3H1.hvecs",
	"data/corel5k_train_annot.hvecs"
	};

for i=1:16
	test{i} = double(vec_read(testStr{i}));
	train{i} = double(vec_read(trainStr{i}));
end

end

