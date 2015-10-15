# Dependencies
iconv= require 'iconv-lite'

# Public
class VpvpVpd
  parse: (buffer)->
    raw= (iconv.decode buffer,'shift_jis').toString().replace /\r\n/g,'\n'
    beginBonePosition= raw.indexOf 'Bone'

    header=
      raw.slice 0,beginBonePosition
      .trim()
      .split /\n/
      .filter (line)-> line.length
      .map (line)-> line.replace /\s/g,''

    chunks=
      raw.slice beginBonePosition
      .split '}'

    bones=
      for chunk in chunks
        [head,positionLine,quaternionLine]= chunk.trim().split /\n/,3
        [id,name]= head.split '{'

        continue unless name

        [position]= positionLine.trim().split ';'
        position= position.split(',').map (vector)-> parseFloat vector

        [quaternion]= quaternionLine.trim().split ';'
        quaternion= quaternion.split(',').map (vector)-> parseFloat vector

        {id,name,position,quaternion}

    {header,bones}

  mangle: (pose)->
    data= []

    for bone in pose.bones
      need= no

      p= bone.position
      need= yes unless p[0] is 0 and p[1] is 0 and p[2] is 0

      q= bone.quaternion
      need= yes unless q[0] is 0 and q[1] is 0 and q[2] is 0 and q[3] is 1

      if need
        data.push bone.name
        data.push vector for vector in bone.position
        data.push vector for vector in bone.quaternion

    data

  restore: (data)->
    bones= []

    i= 0
    while data[i]
      bone=
        name: data[i]
        position: data[i+1..i+3]
        quaternion: data[i+4..i+7]
      bones.push bone

      i+= 8

    bones

module.exports= new VpvpVpd
module.exports.VpvpVpd= VpvpVpd
