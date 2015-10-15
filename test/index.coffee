# Dependencies
vpd= require '../src'
pako= require 'pako'

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

  it '.mangle',->
    bones= vpd.mangle vpd.parse file
    expect(bones.length % 8).toBe 0

    # for querystring
    data= bones.join ','
    deflated= (new Buffer (pako.deflate data,{to:'string'})).toString('base64')
    inflated= pako.inflate (new Buffer deflated,'base64').toString(),{to:'string'}

    expect(deflated.length).toBeLessThan 1500 # 414 Request URI too long
    expect(inflated).toEqual data

  it '.restore',->
    bones= vpd.restore vpd.mangle vpd.parse file
    for bone in bones
      expect(bone.name).toBeTruthy()

      expect(bone.position.length).toBe 3
      for vector in bone.position
        expect(vector).toEqual jasmine.any Number
        expect(vector).not.toBeNaN()

      expect(bone.quaternion.length).toBe 4
      for vector in bone.quaternion
        expect(vector).toEqual jasmine.any Number
        expect(vector).not.toBeNaN()
