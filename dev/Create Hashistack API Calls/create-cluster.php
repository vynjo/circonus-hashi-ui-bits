<?php
    require_once "HTTP/Request2.php;

    $APP   = "Nomad";
    $TOKEN = "7339c41b-48ab-617e-8859-c60ab96edb90";

    # talk to the server
    $request = new HTTP_Request2(
        "https://$APP:$TOKEN@api.circonus.com/metric_cluster",
        HTTP_Request2::METHOD_POST,
    );
    $request->setHeader("Accept","application/json");
    $request->setBody(json_encode((object) array(
      'description' => 'All web requests',
      'name' => 'All Web Rates',
      'queries' => array(
        (object) array(
          'query' => '*nc-*client`host`disk*available',
          'type' => 'average'
        )
      ),
      'tags' => array(
        'service:hashistack',
      )
    )));
    $response = $request->send();

    # decode the JSON
    $result = json_decode($response->getBody());

    # deal with exceptions by accessing the returned json and throwing why
    if (!preg_match("/^2/", $response->getStatus())) {
      throw new Exception(
        $response->getStatus().": ".$result->code." (".$result->message.")"
      );
    }

    # $result now contains the result from the server
    var_dump($result);
?>
