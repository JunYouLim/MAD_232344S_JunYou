import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String userName;
  final String userEmail;

  const Profile({super.key, required this.userName, required this.userEmail});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userName);
    _emailController = TextEditingController(text: widget.userEmail);
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    setState(() {
      _isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: _isEditing ? _saveChanges : _toggleEditing,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      _isEditing
                          ? _buildEditableTextField(_nameController, 'Name', Icons.person)
                          : Text(
                              _nameController.text,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Center(
                  child: Text(
                    'Retired teacher who enjoys morning walks and spending time with my grandchildren. Looking for a hassle-free way to book clinic appointments.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey[700]),
                  ),
                ),
                const SizedBox(height: 20),

                _buildInfoCard(
                  context,
                  icon: Icons.location_on,
                  title: 'Address',
                  value: '123 Yishun Avenue 5, #08-123, Singapore 760123',
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  context,
                  icon: Icons.phone,
                  title: 'Contact',
                  value: '+65 9123 4567',
                ),
                const SizedBox(height: 16),

                // Editable Email
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.pink, size: 32),
                            const SizedBox(width: 12),
                            Text(
                              'Email',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _isEditing
                            ? _buildEditableTextField(_emailController, 'Email', Icons.email)
                            : Text(
                                _emailController.text,
                                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.pink),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required IconData icon, required String title, required String value}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, color: Colors.pink, size: 32),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        subtitle: Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      ),
    );
  }
}
