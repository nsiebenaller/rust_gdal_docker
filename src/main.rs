use gdal::vector::LayerAccess;

const SAMPLE_1: &str = "./files/sample_1.kml";

fn main() {
    let dataset = gdal::Dataset::open(SAMPLE_1).unwrap();
    let num_layers = dataset.layer_count();
    let num_features = crate::count_features(dataset.layers());
    println!(
        "The file '{}' has {} layers and {} features",
        SAMPLE_1, num_layers, num_features
    );
}

fn count_features(layer_iter: gdal::LayerIterator) -> u64 {
    let mut count = 0;
    layer_iter.for_each(|layer| {
        count += layer.feature_count();
    });
    count
}
