THREE.StereoEffect = function(renderer) {

    this.stereo = new THREE.StereoCamera();
    this.stereo.aspect = 0.5;

    this.setSize = function(width, height) {

        renderer.setSize(width, height);

    };
    this.baseScreen = 5.5;
    this.eyeSep = 0.064;
    this.screen = 5.5;
    this.screenSizeChanged = false;
    this.setScreen = function(inch) {
        if (this.screen !== inch) {
            this.screen = inch;
            this.screenSizeChanged = true;
        }
    }
    this.getScreen = function() {
        return this.screen;
    }


    this.updateEyeSep = function(newVal) {
        this.eyeSep = newVal;
        if (this.eyeSep < 0.04)
            this.eyeSep = 0.04;
        if (this.eyeSep > 0.1)
            this.eyeSep = 0.1;
        return this.eyeSep;
    };
    this.getEyeSep = function() {
        return this.eyeSep;
    };

    this.render = function(scene, camera) {
        if (this.screenSizeChanged) {
            camera.fov = 90 + (this.screen - this.baseScreen) * 5;
            this.screenSizeChanged = false;
        }
        camera.updateProjectionMatrix();
        scene.updateMatrixWorld();

        if (camera.parent === null) camera.updateMatrixWorld();

        this.stereo.update(camera, this.eyeSep);

        var size = renderer.getSize();

        renderer.setScissorTest(true);
        renderer.clear();

        renderer.setScissor(0, 0, size.width / 2, size.height);
        renderer.setViewport(0, 0, size.width / 2, size.height);
        renderer.render(scene, this.stereo.cameraL);

        renderer.setScissor(size.width / 2, 0, size.width, size.height);
        renderer.setViewport(size.width / 2, 0, size.width / 2, size.height);
        renderer.render(scene, this.stereo.cameraR);
        renderer.setScissorTest(false);
    };
    this.clear = function(camera) {
        var size = renderer.getSize();
        renderer.clear();
        renderer.setScissor(0, 0, size.width, size.height);
        renderer.setViewport(0, 0, size.width, size.height);
        camera.fov = 90;
    };
};