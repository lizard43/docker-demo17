/**
 * Missile Battery for Missile Command
 * Docker swarm demo
 * 
 * Some Javascript portions based on 
 *     https://github.com/andymason/Missile-Command-JavaScript-Clone
 *
 */

var BATTERY = BATTERY || (function() {

    var mqtt = require('mqtt');

    var mqttClient  = mqtt.connect('mqtt://192.168.0.100');
    
    var color = 'rgb('+getRandomInt(0, 255)+','+getRandomInt(0, 255)+',' +getRandomInt(0, 255)+')';
    console.log('color: ', color);
    
    var xLocation = Math.round(Math.random());
    console.log("X: ", xLocation);
    if (xLocation > 0) {
      xLocation = 480;
    }
    console.log("X: ", xLocation);
    var yLocation = getRandomInt(350, 600);
    console.log("Y: ", yLocation);

    mqttClient.on('connect', function () {
      console.log("Connect to MQTT Broker");
      mqttClient.subscribe('command/missile');
    })
     
    mqttClient.on('message', function (topic, message) {

      console.log(topic.toString())
      console.log(message.toString())

      var missileMessage = JSON.parse(message);
      
      // we know the origin and target
      
      // get the line length
      // Determine line lengths
//      var xlen = missileMessage.target.x - missileMessage.origin.x;
//      var ylen = missileMessage.target.y - missileMessage.origin.y;

        var offset = getRandomInt(1, 10);
        console.log("Offset: ", offset);
        var distance = missileMessage.speed * (50 + offset);
        var xTarget = Math.sin(missileMessage.angle) * distance + missileMessage.origin.x;
        var yTarget = Math.cos(missileMessage.angle) * distance + missileMessage.origin.y;
           
        var target = {
            'x': xTarget,
            'y': yTarget
        };

        var origin = {
            'x': xLocation,
            'y': yLocation
        };

      var rocket = new Rocket(target, origin, color)
      mqttClient.publish("command/rocket", JSON.stringify(rocket),  0, false);
    })    

   function getRandomInt(min, max) {
      return Math.floor(Math.random() * (max - min + 1) + min);
   }

    var engine = (function() {

        // Private variables protected by closure
        var FPS = 1000 / 30,
            _level = 0,
            _new_missile = 10000,
            _missiles_created = 0,
            _missiles_destroyed = 0,
            _gameInterval,
            _entities = {
                'missiles': [],
                'targets': [],
                'rockets': [],
                'turret': []
            },
            _levels = [];

        // launch rocket toward incoming missile
        function launchRocket(event) {
        
        

            var target = {
                'x': event.clientX - this.offsetLeft,
                'y': event.clientY - this.offsetTop
            };

            var turretNumber = getRandomInt(0, 2);

            var originate =  {
                    'turret': turretNumber,
                    'x': _entities.turret[turretNumber].pos.x + (_entities.turret[turretNumber].width / 2),
                    'y': _entities.turret[turretNumber].pos.y
                };

                var rocket = new Rocket(target, originate);
            _entities.rockets.push(rocket);

            websocketclient.publish("command/rocket", JSON.stringify(rocket),  0, false);
        }

        
        // Expose public methods
        return {
            'launchRocket': launchRocket
        };
    }());
    
    /**
     * Game entity class.
     */
    var Entity = function Entity() {};

    /**
    * Draw the game entity on the canvas
    *
    * @param {elm} ctx Canvas context.
    */
    Entity.prototype.draw = function(ctx) {
        ctx.fillStyle = this.colour;
        ctx.fillRect(
            this.pos.x,
            this.pos.y,
            this.width,
            this.height
        );
    };

    /**
     * Missile class
     *
     * @param {object} origin Starting position.
     * @param {object} target Target destination position.
     */
    var Missile = function Missle(origin, target, speed) {
        this.pos = {};
        this.origin = origin || {
            'x': 480 * Math.random(),
            'y': 0
        };
        
        this.target = target || engine.getRandomTarget();
        
        // Calculate angle
        var x = (this.target.pos.x + this.target.width / 2) - this.origin.x;
        var y = this.target.pos.y - this.origin.y;
        this.angle = Math.atan(x / y);

        this.colour = 'rgb(255, 0, 0)';
        this.speed = speed;
        this.distance = 0;
    };

    Missile.prototype.draw = function(ctx) {
        ctx.strokeStyle = this.colour;
        ctx.beginPath();
        ctx.moveTo(this.origin.x, this.origin.y);
        ctx.lineTo(
            this.pos.x,
            this.pos.y
        );
        ctx.closePath();
        ctx.stroke();
    };

    Missile.prototype.move = function() {
        this.distance += this.speed;
        this.pos.x = Math.sin(this.angle) * this.distance + this.origin.x;
        this.pos.y = Math.cos(this.angle) * this.distance + this.origin.y;
    };
    
    Missile.prototype.hasHit = function() {
        if (this.pos.x >= this.target.pos.x &&
            this.pos.y >= this.target.pos.y &&
            this.pos.y <= this.target.pos.y + this.target.width
        ) {
            return true;
        } else {
            return false;
        }
    };
    
    var Rocket = function Rocket(target, origin, color) {
        this.fullRadius = 30;
        this.currentRadius = 0;
        this.expanding = true;
        this.explosionSpeed = 2;
        this.exploded = false;
        this.speed = 10;
        this.distance = 0;
        
        this.target = target;
        
        this.color = color;
        
        // @TODO: Weird turret reference issue causing red turrets to move
        this.origin = origin;
        this.pos = {x: origin.x, y:origin.y};
        
        // Calculate angle
        var x = this.target.x - this.origin.x;
        var y = this.target.y - this.origin.y;
        this.angle = Math.atan(x / y);
        
    };
    
    /* Some comment.
     *
     */
    Rocket.prototype.move = function() {
        if (this.exploded) {
            return;
        }
        
        this.distance -= this.speed;
        
        this.pos.x = Math.sin(this.angle) * this.distance + this.origin.x;
        this.pos.y = Math.cos(this.angle) * this.distance + this.origin.y;
        
        if (this.pos.y < this.target.y) {
            this.exploded = true;
        }
    };
    
    Rocket.prototype.draw = function(ctx) {
        if (this.exploded) {
            if (this.expanding) {
                this.currentRadius += this.explosionSpeed;
                
                if (this.currentRadius >= this.fullRadius) {
                    this.expanding = false;
                }
            } else {
                this.currentRadius -= this.explosionSpeed;
            }
            
            ctx.fillStyle = 'rgb(226, 88, 34)';
            ctx.beginPath();
            ctx.arc(this.pos.x, this.pos.y, this.currentRadius, 0, Math.PI * 2, true);
            ctx.closePath();
            ctx.fill();
        } else {
            ctx.strokeStyle = 'rgb(0, 255, 0)';
            ctx.beginPath();
            ctx.moveTo(this.origin.x, this.origin.y);
            ctx.lineTo(
                this.pos.x,
                this.pos.y
            );
            ctx.closePath();
            ctx.stroke();
        }        
    };

    function init() {
    }

    return {
        'init': init
    };

}());

BATTERY.init();
