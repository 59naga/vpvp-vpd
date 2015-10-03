# Dependencies
vpd= require '../src'
fs= require 'fs'

# Environment
file= fs.readFileSync './test/fixtures/im2019083.vpd'

# Specs
describe 'vpd',->
  it '.parse',->
    pose= vpd.parse file

    expect(pose.header[0]).toBe 'VocaloidPoseDatafile'
    expect(pose.header[1]).toBe '初音ミク七葉HT.osm;//親ファイル名'
    expect(pose.header[2]).toBe '139;//総ポーズボーン数'

    expect(pose.bones.length).toBe 139
    for bone in pose.bones
      expect(bone.id).toMatch /^Bone/
      expect(bone.name).toBeTruthy()

      expect(bone.position.length).toBe 3
      for vector in bone.position
        expect(vector).toEqual jasmine.any Number
        expect(vector).not.toBeNaN()

      expect(bone.quaternion.length).toBe 4
      for vector in bone.quaternion
        expect(vector).toEqual jasmine.any Number
        expect(vector).not.toBeNaN()
