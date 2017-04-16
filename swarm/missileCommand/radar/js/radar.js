/**
 * Radar for Missile Command
 * Docker swarm demo
 * 
 * Some Javascript portions based on 
 *     https://github.com/andymason/Missile-Command-JavaScript-Clone
 *
 */

var RADAR = RADAR || (function() {

    var mqtt = require('mqtt');

    var mqttClient  = mqtt.connect('mqtt://message-broker');

    mqttClient.on('connect', function () {
      console.log("Connect to MQTT Broker");
      mqttClient.subscribe('command/rocket');
    })
     
    mqttClient.on('message', function (topic, message) {
      // message is Buffer 
      console.log(message.toString())
   //   mqttClient.end()
    })    

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

        /**
         * Start the game
         */
        function run() {

            startWave();
            Wave.init();
            _gameInterval = setInterval(_gameLoop, FPS);
        }
        
        function startWave() {
            _new_missile = 0;
            _missiles_created = 0;
            _missiles_destroyed = 0;
        }
        
        /**
         * Pause game
         */
        function _pause() {
            clearInterval(_gameInterval);
        }
        
        function getRandomInt(min, max) {
            min = Math.ceil(min);
            max = Math.floor(max);
            return Math.floor(Math.random() * (max - min)) + min;
        }
        
        /**
         * Game loop
         */
        function _gameLoop() {

            // Wave end?
            if (_missiles_created === Wave.getWave(_level).MissilesToDetroy) {
                _level += 1;
                startWave();
            }
        
            // Add missiles
            if (_new_missile < 0 &&
                _missiles_created < Wave.getWave(_level).MissilesToDetroy
            ) {

                var missile = new Missile(false, false, Wave.getWave(_level).MissileSpeed);
                _entities.missiles.push(missile);
                _missiles_created += 1;
                _new_missile += Wave.getWave(_level).TimeBetweenShots;

                console.log("Detected Missile");
                mqttClient.publish("command/missile", JSON.stringify(missile),  0, false);
            }
            
            _new_missile -= FPS;
        
        }
        
        /**
         * Load and setup a level
         *
         * @param {object} level Level data.
         */
        function loadLevel(level) {
            // Add game entities

            for (var i = 0; i < level.homes.length; i++) {
                _entities.targets.push(new Home(level.homes[i]));
            }

        }

        /**
         * Get random target location
         *
         * @return {object} Target's location.
         */
        function getRandomTarget() {
            var targetCount = _entities.targets.length;
            var rndIndex = Math.floor(targetCount * Math.random());
            var target = _entities.targets[rndIndex];

            return target;
        }
        
        
        // Expose public methods
        return {
            'loadLevel': loadLevel,
            'getRandomTarget': getRandomTarget,
            'run': run
        };
    }());
    
    
    var Wave = (function() {
        var TOTAL_WAVE_NUM = 40,
            _waves = [];
        
        /**
         * Sets up the missile waves
         */
        function init() {
            for (var i = 0; i < TOTAL_WAVE_NUM; i++) {
                _waves[i] = {
                    'MissilesToDetroy': 10 + i,
                    'MirvChance': 30 + i * 4,
                    'BombChance': i * 2,
                    'FlyerChance': 5,
                    'TimeBetweenShots': 3000 - i * 200,
                    'MissileSpeed': 1.9 + (i / 4)
                };
            }
        }
        
        /**
         * Get the wave
         */
        function getWave(level) {
            return _waves[level];
        }
        
        return {
            'init': init,
            'getWave': getWave
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
     * Home entity class
     *
     * @param {object} pos Location position.
     */
    var Home = function Home(pos) {
       this.pos = pos;
       this.width = 20;
       this.height = 10;
       this.colour = 'rgb(128, 128, 128)';
    };
    Home.prototype = new Entity();

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
    


    /**
     * Levels
     */
    var levels = [];
    levels[0] = {
        'homes': [
            { 'x': 55, 'y': 520 },
            { 'x': 105, 'y': 535 },
            { 'x': 158, 'y': 525 },
            { 'x': 270, 'y': 530 },
            { 'x': 325, 'y': 525 },
            { 'x': 390, 'y': 520 }
        ],
        'background': [
            {'colour': 'rgb(0, 5, 20)', 'position': 0},
            {'colour': 'rgb(0, 30, 70)', 'position': 0.7},
            {'colour': 'rgb(0, 60, 120)', 'position': 1}
        ],
        'rocketCount': 5,
        'attackRate': 1,
        'timer': 30
    };

    function init() {
        engine.loadLevel(levels[0]);
        engine.run();
    }

    return {
        'init': init
    };

}());

RADAR.init();
