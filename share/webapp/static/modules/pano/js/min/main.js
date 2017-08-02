/**
 * Created by shiyong on 4/29/16.
 */
function init(){var e;e=document.getElementById("container"),camera=new THREE.PerspectiveCamera(75,window.innerWidth/window.innerHeight,1,1100),camera.target=new THREE.Vector3(0,0,0),scene=new THREE.Scene;var n=new THREE.SphereGeometry(500,60,40);n.scale(-1,1,1);var o=new THREE.MeshBasicMaterial({map:(new THREE.TextureLoader).load("./res/tar.jpg")});mesh=new THREE.Mesh(n,o),scene.add(mesh),renderer=new THREE.WebGLRenderer,renderer.setPixelRatio(window.devicePixelRatio),renderer.setSize(window.innerWidth,window.innerHeight),e.appendChild(renderer.domElement),e.addEventListener("mousedown",onDocumentMouseDown,!1),e.addEventListener("mousemove",onDocumentMouseMove,!1),e.addEventListener("mouseup",onDocumentMouseUp,!1),e.addEventListener("mousewheel",onDocumentMouseWheel,!1),e.addEventListener("MozMousePixelScroll",onDocumentMouseWheel,!1),window.addEventListener("resize",onWindowResize,!1)}function onWindowResize(){camera.aspect=window.innerWidth/window.innerHeight,camera.updateProjectionMatrix(),renderer.setSize(window.innerWidth,window.innerHeight)}function vec3toVec2(e){var n=e.clone(),o=n.project(camera),t=document.getElementsByTagName("canvas")[0],a=t.scrollWidth/2,r=t.scrollHeight/2,i={x:Math.round(o.x*a+a),y:Math.round(-o.y*r+r)};return i}function onDocumentMouseDown(e){e.preventDefault(),mouse.x=e.clientX/window.innerWidth*2-1,mouse.y=2*-(e.clientY/window.innerHeight)+1,console.log(mouse),raycaster.setFromCamera(mouse,camera);var n=raycaster.intersectObject(mesh);if(n.length>0){var o=n[0].point;null===addrPoint&&(addrPoint=o)}isUserInteracting=!0,onPointerDownPointerX=e.clientX,onPointerDownPointerY=e.clientY,onPointerDownLon=lon,onPointerDownLat=lat}function onDocumentMouseMove(e){isUserInteracting===!0&&(lon=.1*(onPointerDownPointerX-e.clientX)+onPointerDownLon,lat=.1*(e.clientY-onPointerDownPointerY)+onPointerDownLat)}function onDocumentMouseUp(e){isUserInteracting=!1}function onDocumentMouseWheel(e){e.wheelDeltaY?camera.fov-=.05*e.wheelDeltaY:e.wheelDelta?camera.fov-=.05*e.wheelDelta:e.detail&&(camera.fov+=1*e.detail),camera.fov<cameraMinFov&&(camera.fov=cameraMinFov),camera.fov>cameraMaxFov&&(camera.fov=cameraMaxFov),camera.updateProjectionMatrix()}function animate(){if(requestAnimationFrame(animate),update(),null!==addrPoint){addrPoint=new THREE.Vector3(470.76959432260077,-75.1807271361399,149.9030314497126);var e=vec3toVec2(addrPoint);$("#addrPoint").offset({top:e.y,left:e.x})}}function update(){lat=Math.max(-85,Math.min(85,lat)),phi=THREE.Math.degToRad(90-lat),theta=THREE.Math.degToRad(lon),camera.target.x=501*Math.sin(phi)*Math.cos(theta),camera.target.y=500*Math.cos(phi),camera.target.z=500*Math.sin(phi)*Math.sin(theta),camera.lookAt(camera.target),renderer.render(scene,camera)}var camera,scene,renderer,mesh,isUserInteracting=!1,onMouseDownMouseX=0,onMouseDownMouseY=0,lon=0,onMouseDownLon=0,lat=0,onMouseDownLat=0,phi=0,theta=0,raycaster=new THREE.Raycaster,mouse=new THREE.Vector2,addrPoint=null,onPointerDownPointerX=null,onPointerDownPointerY=null,cameraMaxFov=100,cameraMinFov=25;init(),animate();