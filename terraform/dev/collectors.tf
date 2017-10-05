// Circonus Enterprise Collectors (aka Brokers)

data "circonus_collector" "GCloud-ns-3c" {
  id = "/broker/1899"
}

// Circonus Public Collectors (aka Brokers)
data "circonus_collector" "ashburn" {
  id = "/broker/1"
}

data "circonus_collector" "san_jose" {
  id = "/broker/2"
}

data "circonus_collector" "amsterdam" {
  id = "/broker/3"
}

data "circonus_collector" "munich" {
  id = "/broker/4"
}

data "circonus_collector" "nagano" {
  id = "/broker/6"
}

data "circonus_collector" "composite" {
  id = "/broker/206"
}

data "circonus_collector" "chicago" {
  id = "/broker/275"
}

data "circonus_collector" "singapore" {
  id = "/broker/276"
}

data "circonus_collector" "london" {
  id = "/broker/32"
}

data "circonus_collector" "httptrap" {
  id = "/broker/35"
}

data "circonus_collector" "caql" {
  id = "/broker/1490"
}
