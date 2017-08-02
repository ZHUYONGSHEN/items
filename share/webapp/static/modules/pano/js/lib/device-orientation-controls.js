/**
 * @author richt / http://richt.me
 * @author WestLangley / http://github.com/WestLangley
 *
 * W3C Device Orientation control (http://w3c.github.io/deviceorientation/spec-source-orientation.html)
 */

THREE.DeviceOrientationControls = function(pano, object, mesh) {

	this.object = object;
	this.object.rotation.reorder("YXZ");
	this.mesh = mesh;
	this.pano = pano;
	this.rotateMesh = true;
	this.freeze = true;
	this.deviceOrientation = {};
	this.offsetMesh = {};
	this.screenOrientation = 0;
	this.orient = null;
	this.supportDeviceOrientation = "onorientationchange" in window ;

	var ctrlThis = this;
	this.onDeviceOrientationChangeEvent = function(rawEvtData) {
		this.deviceOrientation = rawEvtData;
	};

	this.onScreenOrientationChangeEvent = function() {
		this.screenOrientation = window.orientation || 0;;
	};
	this.adjustMesh = function(b) {
		this.rotateMesh = b;
	}
	this.resetAngle = function() {
		this.offsetMesh = {};
	};
	this.pause = function() {
		this.freeze_tmp = true;
	};
	this.play = function() {
		this.freeze_tmp = false;
		this.resetAngle();
	};

	this.update = function() {

		var alpha, beta, gamma, orient;

		return function() {

			if (this.freeze || this.freeze_tmp ||
				$.isEmptyObject(this.deviceOrientation)) return;

			alpha = this.deviceOrientation.alpha ? THREE.Math.degToRad(this.deviceOrientation.alpha) : 0; // Z
			beta = this.deviceOrientation.beta ? THREE.Math.degToRad(this.deviceOrientation.beta) : 0; // X'
			gamma = this.deviceOrientation.gamma ? THREE.Math.degToRad(this.deviceOrientation.gamma) : 0; // Y''
			orient = this.screenOrientation ? THREE.Math.degToRad(this.screenOrientation) : 0; // O

			setObjectQuaternion(alpha, beta, gamma, orient);
		}

	}();

	function bind(scope, fn) {

		return function() {

			fn.apply(scope, arguments);

		};

	};

	this.connect = function() {

		this.onScreenOrientationChangeEvent(); // run once on load

		window.addEventListener('orientationchange', bind(this, this.onScreenOrientationChangeEvent), false);
		window.addEventListener('resize', bind(this, this.onScreenOrientationChangeEvent), false);
		window.addEventListener('deviceorientation', bind(this, this.onDeviceOrientationChangeEvent), false);
		this.resetAngle();
		this.freeze = false;

	};

	this.disconnect = function() {

		this.freeze = true;

		window.removeEventListener('orientationchange', bind(this, this.onScreenOrientationChangeEvent), false);
		window.removeEventListener('resize', bind(this, this.onScreenOrientationChangeEvent), false);
		window.removeEventListener('deviceorientation', bind(this, this.onDeviceOrientationChangeEvent), false);

		if (ctrlThis.object){
			var tq = ctrlThis.object.quaternion.clone();
			var euler = new THREE.Euler();
			euler.setFromQuaternion(tq, 'YXZ');
			euler.z = 0;
			tq.setFromEuler(euler);

			ctrlThis.object.quaternion.copy(tq);
		}
	};

	var self = this;
	// The angles alpha, beta and gamma form a set of intrinsic Tait-Bryan angles of type Z-X'-Y''
	var setObjectQuaternion = function() {

		var zee = new THREE.Vector3(0, 0, 1);

		var euler = new THREE.Euler();

		var q0 = new THREE.Quaternion();

		var q1 = new THREE.Quaternion(-Math.sqrt(0.5), 0, 0, Math.sqrt(0.5)); // - PI/2 around the x-axis

		var tq = new THREE.Quaternion();

		return function(alpha, beta, gamma, orient) {
			euler.set(beta, alpha, -gamma, 'YXZ'); // 'ZXY' for the device, but 'YXZ' for us

			tq.setFromEuler(euler); // orient the device

			tq.multiply(q1); // camera looks out the back of the device, not the top

			tq.multiply(q0.setFromAxisAngle(zee, -orient)); // adjust for screen orientation
			if ($.isEmptyObject(ctrlThis.offsetMesh) && (ctrlThis.rotateMesh === true || ctrlThis.supportDeviceOrientation !== true)) {
				ctrlThis.object.updateMatrixWorld();
				ctrlThis.offsetMesh = ctrlThis.object.quaternion.clone().multiply(tq.conjugate());
			} else {
				
				if (!$.isEmptyObject(ctrlThis.offsetMesh)) {
					tq = ctrlThis.offsetMesh.clone().multiply(tq);
				}

				ctrlThis.object.quaternion.copy(tq);
				pano.bIsChanged = true;
			}
		};

	}();

};