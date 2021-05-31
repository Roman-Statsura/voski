<?php
    use Ratchet\Server\IoServer;
    use Ratchet\Http\HttpServer;
    use Ratchet\WebSocket\WsServer;
    use Ratchet\MessageComponentInterface;
    use Ratchet\ConnectionInterface;

    require dirname(__DIR__) . '/../vendor/autoload.php';
    require_once dirname(__DIR__) . '/../core/model/modx/modx.class.php';
    
    class Chat implements MessageComponentInterface {
        protected $clients;
    
        public function __construct() {
            $this->clients = new \SplObjectStorage;
        }
    
        public function onOpen(ConnectionInterface $conn) {
            $this->clients->attach($conn);
            echo "New connection! ({$conn->resourceId})\n";
        }
    
        public function onMessage(ConnectionInterface $from, $msg) {
            $msg = json_decode($msg);
            $numRecv = count($this->clients) - 1;
            $tvFilter = "";
            echo sprintf('Connection %d sending message with ID "%s" to %d other connection%s' . "\n", $from->resourceId, $msg->resID, $numRecv, $numRecv == 1 ? '' : 's');

            $modx = new modX();
            $modx->initialize('web');
            $modx->getService('error', 'error.modError', '', '');
   
            $params = array(
                'parents' => 36,
                'resources' => $msg->resID,
                'sortby' => 'publishedon', 
                'sortdir' => 'DESC',
                'includeTVs' => 'consultDatetime, consultIDClient, consultIDTarot, consultZoomID, consultZoomLink, 
                                consultZoomStartLink, consultDesc, consultStatusSession, consultDuration, consultSended',
                'includeContent' => '1',
                'return' => 'json', 
                'limit' => 0
            );

            $response = $modx->runSnippet('pdoResources', $params);

            foreach ($this->clients as $client) {
                $client->send($response);
            }
        }
    
        public function onClose(ConnectionInterface $conn) {
            $this->clients->detach($conn);
            echo "Connection {$conn->resourceId} has disconnected\n";
        }
    
        public function onError(ConnectionInterface $conn, \Exception $e) {
            echo "An error has occurred: {$e->getMessage()}\n";
            $conn->close();
        }
    }

    $server = IoServer::factory(
        new HttpServer(
            new WsServer(
                new Chat()
            )
        ),
        8080
    );

    $server->run();