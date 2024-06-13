import React, { useState } from 'react';
import { View, TextInput, Button, StyleSheet } from 'react-native';
import { io } from 'socket.io-client';

// Initialize the socket connection
const socket = io('http://localhost:3000');

const Index = () => {
  const [roomCode, setRoomCode] = useState('');

  const createRoom = () => {
    socket.emit('createRoom', roomCode);
    console.log(`Room created with code: ${roomCode}`);
  };

  const joinRoom = () => {
    socket.emit('joinRoom', roomCode);
    console.log(`Joined room with code: ${roomCode}`);
  };

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.input}
        placeholder="Enter Room Code"
        value={roomCode}
        onChangeText={setRoomCode}
      />
      <Button title="Create Room" onPress={createRoom} />
      <Button title="Join Room" onPress={joinRoom} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  input: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 20,
    width: '80%',
    paddingHorizontal: 10,
  },
});

export default Index;