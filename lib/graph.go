package lib

type RegularGraph struct {
	// 	AccessKeys 			[]interface{}			`json:"access_keys"`
	Description       string        `json:"description"`
	Tags              []string      `json:"tags"`
	Title             string        `json:"title"`
	Cid               string        `json:"_cid"`
	Style             string        `json:"style"`
	Datapoints        []Datapoint   `json:"datapoints"`
	Overlayset        []interface{} `json:"overlay_sets"`
	LineStyle         string        `json:"line_style"`
	LogarithmicRightY interface{}   `json:"logarithmic_right_y"`
	LogarithmicLeftY  interface{}   `json:"logarithmic_left_y"`
	MaxLeftY          interface{}   `json:"max_left_y"`
	Notes             interface{}   `json:"notes"`
	MaxRightY         interface{}   `json:"max_right_y"`
	MinLeftY          interface{}   `json:"min_left_y"`
	// 	Guides 				[]interface{} 			`json:"guides"`
	// 	MetricClusters 		[]interface{} 			`json:"metric_clusters"`
	MinRightY interface{} `json:"min_right_y"`
}

type ReturningGraph struct {
	AccessKeys        []interface{} `json:"access_keys"`
	OverlaySets       interface{}   `json:"overlay_sets"`
	Composites        []interface{} `json:"composites"`
	Style             string        `json:"style"`
	Cid               string        `json:"_cid"`
	Description       string        `json:"description"`
	LineStyle         string        `json:"line_style"`
	Tags              []interface{} `json:"tags"`
	LogarithmicRightY interface{}   `json:"logarithmic_right_y"`
	LogarithmicLeftY  interface{}   `json:"logarithmic_left_y"`
	Datapoints        []struct {
		LegendFormula interface{} `json:"legend_formula"`
		Caql          interface{} `json:"caql"`
		CheckID       int         `json:"check_id"`
		MetricType    string      `json:"metric_type"`
		Stack         int         `json:"stack"`
		Name          string      `json:"name"`
		Axis          string      `json:"axis"`
		DataFormula   interface{} `json:"data_formula"`
		Color         string      `json:"color"`
		MetricName    string      `json:"metric_name"`
		Alpha         string      `json:"alpha"`
		Derive        string      `json:"derive"`
		Hidden        bool        `json:"hidden"`
	} `json:"datapoints"`
	MaxLeftY       interface{}   `json:"max_left_y"`
	Notes          interface{}   `json:"notes"`
	Title          string        `json:"title"`
	MaxRightY      interface{}   `json:"max_right_y"`
	MinLeftY       interface{}   `json:"min_left_y"`
	Guides         []interface{} `json:"guides"`
	MetricClusters []interface{} `json:"metric_clusters"`
	MinRightY      interface{}   `json:"min_right_y"`
}
