package arm;

class SceneBuilder extends armory.Trait {

	var dist = 0.0;
	var tileNum = 0;
	var tiles:Array<iron.object.Object> = [];
	var empty:iron.object.Object;

	function spawnTile(num:Int) {
		iron.Scene.active.spawnObject("Tile" + Std.random(2), null, function(o) {
			tiles.push(o);
			o.transform.loc.x = 0;
			o.transform.loc.y = num * 4.0;
			o.transform.buildMatrix();

			// Spawn gem
			if (Std.random(3) == 0) {
				iron.Scene.active.spawnObject("Gem", o, function(go) {
					go.transform.loc.x = (Math.random() - 0.5) * 1.8;
					go.transform.loc.z = 0.2;
					go.transform.buildMatrix();
				});
			}

			// Remove old tiles
			if (tiles.length > 14) {
				o = tiles.shift();
				o.remove();
			}
		});
	}

	public function new() {
		super();

		notifyOnUpdate(function() {
			if (empty == null) empty = iron.Scene.active.getChild("Empty");

			// Spawn new tiles
			while (tileNum < Std.int(dist / 4 + 14)) spawnTile(tileNum++);

			// Travel forward
			dist += 0.1;
			empty.transform.loc.y = dist;
			empty.transform.buildMatrix();
		});
	}
}
